import kafka.serializer.StringDecoder
import org.apache.spark.sql.SQLContext
import org.apache.spark.{SparkConf, SparkContext}
import org.apache.spark.mllib.recommendation.MatrixFactorizationModel
import org.apache.spark.streaming.kafka.KafkaUtils
import org.apache.spark.streaming.{Duration, StreamingContext}
import scala.collection.mutable.ArrayBuffer

case class UserRating(userId:String, movieId:String, rating:String)
val batchDuration = new Duration(5000)
// batchDuration为时间间隔

val ssc = new StreamingContext(sc, batchDuration)
val topics = Set("movielog")
val kafkaParams = Map("metadata.broker.list" -> "172.19.0.9:9092")
println("start....")
val messages = KafkaUtils.createDirectStream[String, String, StringDecoder, StringDecoder](ssc, kafkaParams, topics)
println(messages.count())

ssc.start() // 真正启动程序
ssc.awaitTermination() //阻塞等待