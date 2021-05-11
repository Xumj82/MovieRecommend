package com.local.rec

//import com.southeast.caseclass.{Result, Result2}
import com.local.caseclass.Result2
import com.local.conf.AppConf
import com.local.utils.ToMySQLUtils
import org.apache.spark.mllib.recommendation.MatrixFactorizationModel
import org.apache.spark.sql.SaveMode
import org.jblas.DoubleMatrix
import java.lang.Exception

/**
  * Created by ZXL on 2018/3/1.
  */

object RecommandForAllMovies extends AppConf{
  /**
    * 相似度函数
    *
    * @param vec1
    * @param vec2
    * @return
    */
  def cosineSimilarity(vec1: DoubleMatrix, vec2: DoubleMatrix): Double = {
    //double dot(DoubleMatrix other) The scalar product(乘积) of this with other.
    //double norm2() The Euclidean norm(欧几里德范数,即开平方) of the matrix as vector,
    // also the Frobenius norm(弗罗贝尼乌斯范数,即对应元素的平方和再开方) of the matrix.
    vec1.dot(vec2) / (vec1.norm2() * vec2.norm2())
  }

  def main(args: Array[String]){
    val modelpath = "model/"
    val model = MatrixFactorizationModel.load(sc, modelpath)

    val movieIds=sc.textFile("data/training.dat").map(line=>{
      val fields=line.split("\t")
      fields(1).toInt
    }).distinct().toLocalIterator

    //这里有点问题
    while(movieIds.hasNext) {
      val movieId = movieIds.next()

      // 获取该物品的隐因子向量
      val movieFactor = model.productFeatures.lookup(movieId).head
      // 将该向量转换为jblas矩阵类型
      val movieVector = new DoubleMatrix(movieFactor)

      // 计算电影567与其他电影的相似度
      val sims = model.productFeatures.map{ case (id, factor) =>
        val factorVector = new DoubleMatrix(factor)
        val sim = cosineSimilarity(factorVector, movieVector)
        (id, sim)
      }

      val sortedSims = sims.top(5)(Ordering.by[(Int, Double), Double] {
        case (id, similarity) => similarity
      })

      val result=sortedSims.map(line=>{
        Result2(movieId,line._1,line._2)
      }).toList

      import sqlContext.implicits._
      val resultDF=result.toDF
      ToMySQLUtils.toMySQL(resultDF,"movie_movie",SaveMode.Append)
    }
  }
}
