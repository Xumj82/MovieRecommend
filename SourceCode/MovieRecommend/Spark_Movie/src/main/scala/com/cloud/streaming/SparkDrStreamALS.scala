package com.cloud.streaming
import com.cloud.conf.AppConf

import java.sql.{Connection, DriverManager}
import com.cloud.caseclass.{Heartbreak, Result, UserRating}
import com.cloud.utils.DBUtils
import kafka.serializer.StringDecoder
import org.apache.spark.{SPARK_VERSION, SparkConf, SparkContext}
import org.apache.spark.mllib.recommendation.MatrixFactorizationModel
import org.apache.spark.sql.hive.HiveContext
import org.apache.spark.streaming.kafka.KafkaUtils
import org.apache.spark.streaming.{Duration, StreamingContext}

import scala.collection.mutable.ArrayBuffer


/**
  * 接收kafka产生的数据，进行处理
  * Created by ZXL on 2018/3/11.
  */
object SparkDrStreamALS extends Serializable {

  def main(args: Array[String]) {
    //    val conf = new SparkConf().setAppName("SparkDrStream").setMaster("spark://movie1:7077")

    val conf = new SparkConf().setAppName("SparkDrStream").setMaster("local[2]")
    val sc = new SparkContext(conf)
    val hc = new HiveContext(sc)
    val modelpath = "/tmp/Model"
    val model = MatrixFactorizationModel.load(sc, modelpath)
    // Duration对象中封装了时间的一个对象，它的单位是ms.
    val batchDuration = new Duration(5000)
    // batchDuration为时间间隔
    val ssc = new StreamingContext(sc, batchDuration)
    ssc.checkpoint("/data/movieck2")
    val topics = Set("movielog")
    val kafkaParams = Map("metadata.broker.list" -> "kafka:9092")
    val messages = KafkaUtils.createDirectStream[String, String, StringDecoder, StringDecoder](ssc, kafkaParams, topics)
    messages.print()
    val messagesDStream = messages.map(_._2).map(line => {
      var heartbreak: Heartbreak = null
      if (line != null) {
        try {
          val fields = line.split(",")
          if (fields.length == 5) {
            println(fields(0))
            heartbreak = Heartbreak(fields(0).toInt, fields(1).toInt, fields(2).toInt,fields(3).toInt,0)
          }
        } catch {
          case e => e
            println("Error")
        }
      }
      heartbreak
    }).filter(x=>x != null)


    messagesDStream.print()
    messagesDStream.foreachRDD(rec=>{
      rec.collect().foreach(x=>{
        println(x.count+" ; "+x.star+" ; "+x.time)
        if(x.count>=10 || x.star>4){
          //val rec = model.recommendProducts(x.userid ,10)
          //val uidString = rec.map(x => x.user.toString() + "," + x.product.toString() + "," + x.rating.toString())
          val similarMovies = get5SimilarMovies(x.movieid).toList
          val recMovies = similarMovies
          val recMoviesStr = recMovies.toList.distinct
          recMoviesStr.foreach(x=>{
            println(x)
          })
          // 将推荐结果写入数据库
          resultInsertIntoMysql(x.userid, recMoviesStr.mkString(","))
        }
      })
    })

//    pagetime.foreachRDD(rdd => {
//      if (!rdd.isEmpty()) {
//        val pagetime = rdd.map{case Heartbreak(userid, movieid , count)=>(userid.toInt,movieid.toInt,count.toInt)}.toLocalIterator
//        println(pagetime)
//        while (pagetime.hasNext) {
//
//            val rec = pagetime.next()
//            val user = rec._1
//            val movie = rec._2
//            if(rec._3>=3){
//              val rec = model.recommendProducts(user ,5)
//              val uidString = rec.map(x => x.user.toString() + "," + x.product.toString() + "," + x.rating.toString())
//              val movieIds = uidString.map(_.split(",")).filter(x => x(2).trim().toDouble >= 4.0).map(x => x(1).trim().toInt)
//                        movieIds.foreach(x=>{
//                          println(x)
//                        })
//              val similarMovies = get5SimilarMovies(movie)
//              val recMovies = movieIds ++ similarMovies
//              val recMoviesStr = recMovies.toList.distinct
//              Random.shuffle(recMoviesStr).take(5)
//              recMoviesStr.foreach(x=>{
//                println(x)
//              })
//              // 将推荐结果写入数据库
//              //resultInsertIntoMysql(user, recMoviesStr.mkString(","))
//            }
//          }
//      }
//      //        val ratings = rdd.map { case UserRating(user, movie, rating) => (user.toInt, movie.toInt) }.distinct().toLocalIterator
//      // 如果userId相同则不存入数据库直接更新即可
//      //        while (ratings.hasNext) {
//      //          Thread.sleep(5000)
//      //          val use_movie = ratings.next()
//      //          val user = use_movie._1.toInt
//      //          val movie = use_movie._2.toInt
//      //          val rec = model.recommendProducts(user,5)
//      //
//      //          val uidString = rec.map(x => x.user.toString() + "," + x.product.toString() + "," + x.rating.toString())
//      //
//      ////
//      //
//      ////        val uidDFArray = sc.parallelize(uidString)
//      //          val movieIds = uidString.map(_.split(",")).filter(x => x(2).trim().toDouble >= 4.0).map(x => x(1).trim().toInt)
//      //          movieIds.foreach(x=>{
//      //            println(x)
//      //          })
//      ////
//      //          // 根据电影相似度推荐5部电影
//      //
//      //          val als = new ALS().setMaxIter(100).setRank(1).setRegParam(1.0)
//      //          val p = new Pipeline().setStages(Array(als))
//      //          val similarMovies = get5SimilarMovies(movie)
//      //
//      //          val recMovies = movieIds ++ similarMovies
//      //
//      //          val recMoviesStr = recMovies.toList.distinct
//      //          Random.shuffle(recMoviesStr).take(5)
//      //          recMoviesStr.foreach(x=>{
//      //            println(x)
//      //          })
//      // 将推荐结果写入数据库
//      //resultInsertIntoMysql(user, recMoviesStr.mkString(","))
////
////
////      }
////    }
//
//    })


    ssc.start()
    ssc.awaitTermination()
  }

  // 获取与某部电影最相似的5部电影
  def get5SimilarMovies(movieId: Int): Array[Int] = {
    var movies = ArrayBuffer[Int]()
    var connection:Connection = null
    try {
      connection = DBUtils.getConnection()
      val statement = connection.createStatement()
      val resultSet = statement.executeQuery("select itemid2 from similartab where itemid1 = " + movieId + " order by similar limit 5")

      while (resultSet.next()) {
        movies += resultSet.getInt("itemid2")
      }
    } catch {
      case e => e.printStackTrace
    }
    DBUtils.close(connection)
    movies.toArray
  }

  // 将推荐结果写入数据库中
  def resultInsertIntoMysql(userId:Int,movieIds:String): Unit ={
    var connection:Connection = null
    try {
      connection=DBUtils.getConnection()

      // 检查数据库中该id是否存在
      val statement = connection.createStatement()
      val resultSet = statement.executeQuery("select count(1) from recTab where userId = " + userId)
      resultSet.next()
      val isHaving = resultSet.getInt(1)
      println(isHaving)
      if(isHaving == 0){
        val sql="insert into recTab values(?,?)"
        val pst=connection.prepareStatement(sql)
        pst.setInt(1, userId)
        pst.setString(2, movieIds)
        pst.execute()
      } else{
        val sql="update recTab set movieIds=? where userId=?"
        val pst=connection.prepareStatement(sql)
        pst.setString(1,movieIds)
        pst.setInt(2,userId)
        pst.execute()
      }

    } catch {
      case e => e.printStackTrace
    }
    DBUtils.close(connection)
  }

}

