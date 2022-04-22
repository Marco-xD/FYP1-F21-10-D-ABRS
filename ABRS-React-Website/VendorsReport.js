import React from 'react'
import "./VendorsReport.css"

function VendorsReport({vendorsetisOpen}) {
    function closeVendorsReport(e){
        e.preventDefault();
        vendorsetisOpen(false);
    }
  return (
    <div className='baseVendors'>
        <div className='vendorclosebutton'>
            <button onClick={closeVendorsReport}>close</button>
        </div>
        <div class='vendorsContainer'>
            <iframe title="Purchase_AW - Page 1" width="90%" height="97%" src="https://app.powerbi.com/view?r=eyJrIjoiNzBmMTc3YWMtMTUwNy00ZjBjLWJiNTMtZGMyMDhmZTI0NGJjIiwidCI6IjBkNmYzN2RmLWZhMWEtNDQ4OC04NDBhLWE0NmQ2ZjgyODJiZSIsImMiOjl9" frameborder="0" allowFullScreen="true"></iframe>
        </div> 
    </div>
  )
}

export default VendorsReport    