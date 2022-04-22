import React from 'react'
import "./Tools.css"
import hadoop from "../imgs/hadoop3.png"
import impala from "../imgs/cloudera-impala.png"
import hive from "../imgs/hive.png"
import powerbi from "../imgs/powerbi2.png"

function Tools() {
  return (
    <div className='baseToolsContainer'>
        <div id='Tools'>
            <div className='toolsHeading'>
                    TOOLS AND TECHNOLOGIES
                </div>
            <div className='toolsContainer'>
                <div className='hadoopPNG'>
                    <img src={hadoop} alt='hadoop'></img>
                </div>
                <div className='toolsDESC' id='hadoopdesc'>
                    Hadoop is an open-source software framework for storing data and running applications on clusters of commodity hardware. It provides massive storage for any kind of data, enormous processing power and the ability to handle virtually limitless concurrent tasks or jobs.
                </div>
                

                <div className='toolsDESC' id='impaladesc'>
                    Apache Impala is an open source massively parallel processing SQL query engine for data stored in a computer cluster running Apache Hadoop. It provides high-performance, low-latency SQL queries on data stored in popular Apache Hadoop file formats.
                </div>
                <div className='impalaPNG'>
                    <img src={impala} alt='impala'></img>
                </div>

                
                <div className='hivePNG'>
                    <img src={hive} alt='hive'></img>
                </div>
                <div className='toolsDESC' id='hivedesc'>
                    Hive enables data summarization, querying, and analysis of data. Hive queries are written in HiveQL, which is a query language similar to SQL. Hive allows you to project structure on largely unstructured data.
                </div>

                <div className='toolsDESC' id='bidesc'>
                    Microsoft Power BI is a business intelligence platform that provides nontechnical business users with tools for aggregating, analyzing, visualizing and sharing data.
                </div>
                <div className='powerbiPNG'>
                    <img src={powerbi} alt='powerbi'></img>
                </div>
                
            </div>
        </div>
    </div>
  )
}

export default Tools