package com.cloud.ml

import org.apache.spark.{SparkConf, SparkContext}
import org.apache.spark.ml.evaluation.RegressionEvaluator
import org.apache.spark.ml.recommendation.ALS
import org.apache.spark.ml.tuning.{ParamGridBuilder, TrainValidationSplit}
import org.apache.spark.sql.hive.HiveContext
import org.apache.spark.ml.Pipeline
import org.apache.spark.sql.Dataset
/**
  * 基于dataframe来构建SPARK MLLIB应用。
  * spark.ml是基于DATAFRAME来构建pipeline,通过pipeline来完成机器学习的流水线
  * Created by ZXL on 2018/3/11.
  */
object PipeLine  {

  //基于dataframe来构建你的SPARK MLLIB应用。
  //spark.ml是基于DATAFRAME来构建pipeline,通过pipeline来完成机器学习的流水线
  def main(args: Array[String]) {
    //val trainingData = hc.sql("select * from trainingdata").withColumnRenamed("userid", "user").withColumnRenamed("movieid", "item")
    //val testData = hc.sql("select * from testdata").withColumnRenamed("userid", "user").withColumnRenamed("movieid", "item")
    val clusterMasterURL = "spark://spark1:7077"
    val conf = new SparkConf().setAppName("Pipeline").setMaster(clusterMasterURL)
    val sc = new SparkContext(conf)
    val hc = new HiveContext(sc)
    val trainingData = hc.sql("select * from trainingdata").withColumnRenamed("userid", "user").withColumnRenamed("movieid", "item")
    val testData = hc.sql("select * from testdata").withColumnRenamed("userid", "user").withColumnRenamed("movieid", "item")
    val als = new ALS()    //定义一个ALS类
//      .setMaxIter(5)        //迭代次数，用于最小二乘交替迭代的次数
//      .setRegParam(0.01)    //惩罚系数
//      .setUserCol("userId")    //userid
//      .setItemCol("movieId")    //itemid
//      .setRatingCol("rating")    //rating矩阵，这里跟你输入的字段名字要保持一致。很明显这里是显示评分得到的矩阵形式

    // Evaluate the model by computing the RMSE on the test data
    // Note we set cold start strategy to 'drop' to ensure we don't get NaN evaluation metrics

    val evaluator = new RegressionEvaluator()
      .setMetricName("rmse")
      .setLabelCol("rating")
      .setPredictionCol("prediction")

    println("end als and begin paramGrid ----------")
    val paramGrid = new ParamGridBuilder()
      .addGrid(als.regParam,Array(0.001,0.005,0.01))
      .addGrid(als.maxIter,Array(5,10,20))
      .addGrid(als.rank,Array(4,8))
      .build()

    println("end evaluator and begin TV ")
    val trainValidationSplit = new TrainValidationSplit()
      .setEstimator(als)
      .setEvaluator(evaluator)
      .setEstimatorParamMaps(paramGrid)

    println("begin tv model__________")
    val tvmodel = trainValidationSplit.fit(trainingData)
    tvmodel.transform(testData)
      .select("user", "rating", "prediction")
      .show()
    val model = tvmodel.bestModel
    //构建一个estimator
//    val als = new ALS().setMaxIter(20).setRegParam(1).setRank(1)
//    //ml里的transformer
//    //val model = als.fit(trainingData)
//    val model = new Pipeline().setStages(Array(als)).fit(trainingData)
//    val result = model.transform(testData).select("rating", "prediction")
//    val MSE = result.map(x => math.pow((x.getInt(0) - x.getInt(1)), 2)).mean()
//    val RMSE = math.sqrt(MSE)
  }
}
