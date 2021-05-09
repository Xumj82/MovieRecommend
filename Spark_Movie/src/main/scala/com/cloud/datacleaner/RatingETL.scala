package com.cloud.datacleaner

import com.cloud.caseclass.{UserRating, Users}
import com.cloud.conf.AppConf
import com.cloud.datacleaner.UserETL._
import org.apache.spark.sql.SaveMode

/**
  * Created by ZXL on 2018/3/18.
  */
object RatingETL extends AppConf {

  def main(args: Array[String]) {

    import sqlContext.implicits._

    // 2 读取样本数据
    val ratingdata = hc.sql("select * from ratings").toDF()
    //val ratingdata = data.map(_.split(",")).map(f => UserRating(f(0).toInt,f(1).toInt,f(2).toDouble)).cache()

    //val userDF = ratingdata.toDF()
    ratingdata.show()
    // 存储结果至数据库
    ratingdata.write.mode(SaveMode.Append).jdbc(jdbcURL, ratingTable, prop)
  }
}
