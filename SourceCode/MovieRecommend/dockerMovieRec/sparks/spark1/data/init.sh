#!/bin/bash
echo "start hadoop.."
/usr/local/hadoop-2.6.4/sbin/start-all.sh
echo "start spark.."
usr/local/spark-1.6.2-bin-hadoop2.6/sbin/start-all.sh
echo "start hive.."
/usr/local/apache-hive-1.2.1-bin/bin/hive --service metastore -p 9083