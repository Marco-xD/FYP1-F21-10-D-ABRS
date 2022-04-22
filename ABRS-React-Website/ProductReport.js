import React from 'react'
import "./ProductReport.css"

function ProductReport({productsetisOpen}) {
    function closeProductsReport(e){
        e.preventDefault();
        productsetisOpen(false);
    }
  return (
    <div className='baseProducts'>
        <div className='prodclosebutton'>
            <button onClick={closeProductsReport}>close</button>
        </div>
        <div class='productsContainer'>
            <iframe title="Product_AW - Page 1" width="90%" height="97%" src="https://app.powerbi.com/view?r=eyJrIjoiNjUzYjMwMjQtZmFmZi00NGVhLTg2Y2MtYWE4N2EzYzg4ZjRmIiwidCI6IjBkNmYzN2RmLWZhMWEtNDQ4OC04NDBhLWE0NmQ2ZjgyODJiZSIsImMiOjl9" frameborder="0" allowFullScreen="true"></iframe>
        </div> 
    </div>
  )
}

export default ProductReport