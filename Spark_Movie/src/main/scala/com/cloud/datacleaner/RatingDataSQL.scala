package com.cloud.datacleaner

import com.cloud.caseclass.Ratings
import com.cloud.utils.DBUtils
import org.apache.spark.rdd.RDD
import org.apache.spark.{SparkConf, SparkContext}
import org.apache.spark.sql.{SQLContext, SaveMode}
import org.apache.spark.sql.hive.HiveContext

import java.sql.Connection
import scala.collection.mutable.ArrayBuffer

object RatingDataSQL {
  def main(args: Array[String]) {
    val localClusterURL = "local[2]"
    val clusterMasterURL = "spark://spark1:7077"
    val conf = new SparkConf().setAppName("RatingData").setMaster(clusterMasterURL)
    val sc = new SparkContext(conf)
    val sqlContext = new SQLContext(sc)
    val hc = new HiveContext(sc)
    import sqlContext.implicits._
    // RDD[UserRating]需要从原始表中提取userid,movieid,rating数据
    // 并把这些数据切分成训练集和测试集数据
    // 调用cache table tableName即可将一张表缓存到内存中，来极大的提高查询效率
    val ratings =sc.parallelize(getAllReviews())
    ratings.toDF().show(20)

    ratings.toDF().write.mode(SaveMode.Overwrite).parquet("/tmp/ratings")
    hc.sql("drop table if exists ratings")
    hc.sql("create table if not exists ratings(userId int,movieId int,rating double,timestamp int) stored as parquet")
    hc.sql("load data inpath '/tmp/ratings' overwrite into table ratings")

    // 取第一行第一列元素
    val count = hc.sql("select count(*) from ratings").first().getLong(0)
    val percent = 0.6
    val trainingdatacount = (count * percent).toInt
    val testdatacount = (count * (1 - percent)).toInt

    // 用scala feature:String Interpolation来往SQL语句中传递参数
    // order by limit的时候，需要注意OOM(Out Of Memory)的问题
    // 将数据按时间升序排序
    val trainingDataAsc = hc.sql(s"select userId,movieId,rating from ratings order by timestamp asc")
    trainingDataAsc.show()
    trainingDataAsc.write.mode(SaveMode.Overwrite).parquet("/tmp/trainingDataAsc")
    hc.sql("drop table if exists trainingDataAsc")
    hc.sql("create table if not exists trainingDataAsc(userId int,movieId int,rating double) stored as parquet")
    hc.sql("load data inpath '/tmp/trainingDataAsc' overwrite into table trainingDataAsc")

    // 将数据按时间降序排序
    val trainingDataDesc = hc.sql(s"select userId,movieId,rating from ratings order by timestamp desc")
    trainingDataDesc.write.mode(SaveMode.Overwrite).parquet("/tmp/trainingDataDesc")
    hc.sql("drop table if exists trainingDataDesc")
    hc.sql("create table if not exists trainingDataDesc(userId int,movieId int,rating double) stored as parquet")
    hc.sql("load data inpath '/tmp/trainingDataDesc' overwrite into table trainingDataDesc")

    // 获取60%数据进行训练模型
    val trainingData = hc.sql(s"select * from trainingDataAsc limit $trainingdatacount")
    trainingData.write.mode(SaveMode.Overwrite).parquet("/tmp/trainingData")
    hc.sql("drop table if exists trainingData")
    hc.sql("create table if not exists trainingData(userId int,movieId int,rating double) stored as parquet")
    hc.sql("load data inpath '/tmp/trainingData' overwrite into table trainingData")

    // 获取40%数据进行测试模型
    val testData = hc.sql(s"select * from trainingDataDesc limit $testdatacount")
    testData.write.mode(SaveMode.Overwrite).parquet("/tmp/testData")
    hc.sql("drop table if exists testData")
    hc.sql("create table if not exists testData(userId int,movieId int,rating double) stored as parquet")
    hc.sql("load data inpath '/tmp/testData' overwrite into table testData")

  }

  def getAllReviews(): Array[Ratings] = {
    var ratings = ArrayBuffer[Ratings]()
    var connection:Connection = null
    try {
      connection = DBUtils.getConnection()
      val statement = connection.createStatement()
      val resultSet = statement.executeQuery("SELECT userid,movieid,star,UNIX_TIMESTAMP(reviewtime) as time FROM movie.review;")
      while (resultSet.next()) {
        val rating = Ratings(resultSet.getInt("userid"),resultSet.getInt("movieid"),resultSet.getInt("star"),resultSet.getInt("time"))
        ratings += rating
      }
    } catch {
      case e => e.printStackTrace
    }
    DBUtils.close(connection)
    ratings.toArray
  }
}
