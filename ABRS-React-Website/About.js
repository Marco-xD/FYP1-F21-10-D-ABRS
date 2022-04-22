import React from 'react'
import './About.css'
import ticks from "../imgs/ticks.png"


function About() {
  return (
    <div className='baseAbout'>
      <div id='About'>
          <div className='aboutHeading'>
            ABOUT US
          </div>
          <div className='aboutDesc'>
            Making data and analytics easy and accessible for everyone.
          </div>
          <div className='aboutContent'>
            <div className='aboutContentModule'>
              <div className='aboutleftcontent'>
                We help innovative organizations across all industries tackle transformational use cases and extract real-time insights from an ever-increasing amount of data to drive value and competitive differentiation.
                For this particular project, Adventure Works' dataset was used. Adventure Works is a large, multinational manufacturing company that produces and distributes metal and composite bicycles to commercial markets in North America, Europe, and Asia.


              </div>
              <div className='aboutleftlist'>  
                <ul>
                    <li><img src={ticks}></img>Data collection in CSV file format.</li>
                    <li><img src={ticks}></img>Data cleaning in the staging and integration layers.</li>
                    <li><img src={ticks}></img>Data loading in the semantic layer.</li>
                    <li><img src={ticks}></img>Report generation through Power BI in the semantic layer.</li>
                </ul>
              </div>
            </div>
            <div className='aboutContentModule'>
              <div className='aboutrightcontent'>
                Easily transform all data, anywhere, into meaningful business insight. This is sample text to fill the space.
                
              </div>
              <div className='aboutButton'>
                <a href="#Tools">Learn More</a>
              </div>
            </div>
          </div>

          <div className='aboutStrip'>
              <div className='aboutStripModule'>
                  <div className='aboutSMTop'>
                        4M+
                  </div>
                  <div className='aboutSMBottom'>
                        Rows
                  </div>
              </div>

              <div className='aboutStripModule'>
                  <div className='aboutSMTop'>
                        800M
                  </div>
                  <div className='aboutSMBottom'>
                        Entries
                  </div>
              </div>

              <div className='aboutStripModule'>
                  <div className='aboutSMTop'>
                        8GB
                  </div>
                  <div className='aboutSMBottom'>
                        Data
                  </div>
              </div>
              <div className='aboutStripModule'>
                  <div className='aboutSMTop'>
                        4
                  </div>
                  <div className='aboutSMBottom'>
                        Reports
                  </div>
              </div>

          </div>
        </div>
        

    </div>
  )
}

export default About