package com.cloud.modeltrain

import com.cloud.caseclass.Result
import com.cloud.conf.AppConf
import org.apache.spark.SparkContext
import org.apache.spark.mllib.recommendation.{Rating, MatrixFactorizationModel}
import org.apache.spark.sql.{SaveMode, SQLContext}
import org.apache.phoenix.spark._

object RecommendForAllUsers extends AppConf {
  def main(args: Array[String]) {
    val users = hc.sql("select distinct(userId) from trainingData order by userId asc")
    val allusers = users.map(_.getInt(0))
    val modelpath = "hdfs://spark1:9000/tmp/Model"
    val model = MatrixFactorizationModel.load(sc, modelpath)
    println("Start....")

    val userList = allusers.collect();
    for ( user <- userList ) {
      try{
        val rec = model.recommendProducts(user, 5)
        writeRecResultToMysql(rec, sqlContext, sc)
      }catch {
        case ex: Throwable => {
          println(ex.toString)
        }
      }

    }


    def writeRecResultToMysql(uid: Array[Rating], sqlContext: SQLContext, sc: SparkContext) {
      val uidString = uid.map(x => x.user.toString() + ","
        + x.product.toString() + "," + x.rating.toString())

      import sqlContext.implicits._
      val uidDFArray = sc.parallelize(uidString)
      val uidDF = uidDFArray.map(_.split(",")).map(x => Result(x(0).trim().toInt, x(1).trim.toInt, x(2).trim().toDouble)).toDF
      // 写入mysql数据库，数据库配置在 AppConf中
      uidDF.write.mode(SaveMode.Append).jdbc(jdbcURL, alsTable, prop)
    }

  }
}
