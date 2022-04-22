import React from 'react'
import "./SalesReport.css"


function SalesReport({salesetisOpen}) {
    function closeSalesReport(e){
        e.preventDefault();
        salesetisOpen(false);
    }

  return (
    <div className='baseSales'>
        <div className='closebutton'>
            <button onClick={closeSalesReport}>close</button>
        </div>
        <div class='salesContainer'>
            <iframe title="Sales_AW - Page 1" width="90%" height="97%" src="https://app.powerbi.com/view?r=eyJrIjoiZjQzYzYwZjQtNWIyNy00MDY5LTlhZGYtNWJjNDg4NGViY2QxIiwidCI6IjBkNmYzN2RmLWZhMWEtNDQ4OC04NDBhLWE0NmQ2ZjgyODJiZSIsImMiOjl9" frameborder="0" allowFullScreen="true"></iframe>
        </div> 
    </div>
  )
}

export default SalesReport