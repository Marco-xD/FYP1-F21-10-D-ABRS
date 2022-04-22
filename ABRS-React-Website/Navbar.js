import React from 'react';
import "./Navbar.css";

function Navbar({showLogOut,setShowLogOut,handleLogOut,setShowLogin}) {

    function toggleLogIn(e){
        e.preventDefault();
        setShowLogin(true); 
        setShowLogOut(true);
        
    }

  return (
    
    <div className='baseContainer'>
        <div className='Logo'>
            ABRS
        </div>
        <div className='moduleContainer'>
            <div className='Modules'>
                <a href="#Home">Home</a>
            </div>
            <div className='Modules'>
                <a href="#About">About</a>
            </div>
            <div className='Modules'>
                <a href="#Tools">Tools</a>
            </div>
            <div className='Modules'>
                {showLogOut && <a href="#Analytics">Analytics</a>}
                
            </div>
            <div id="signin" className='Modules'>
                {showLogOut ? (
                    <button onClick={handleLogOut}>Logout</button>
                ): (
                    <button onClick={toggleLogIn}>Analytics</button>
                    
                )}
                
            </div>       
        </div>
    </div>
  )
}

export default Navbar