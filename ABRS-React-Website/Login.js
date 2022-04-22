
import React from 'react';
import './Login.css';
import envelope from '../imgs/email.png'
import lock from '../imgs/lock.png'
import { Email } from '@material-ui/icons';


function Login({email,setEmail,password,setPassword,handleLogIn,emailError,passwordError}) {
    
  return (
    <div className='baseLogin' id='baseLogin'>
        <div className='loginModal'>
            <div className='loginContainer'>
                <span className='loginHeading'>
                    Employee Login
                </span>
                <div className='form'>
                    <div className='formInput'>
                        <div className='emailIcon'>
                            <img src={envelope} alt='email'></img>
                        </div>
                        <input type="text" autoFocus required value={email} placeholder="Email" onChange={(e)=>{setEmail(e.target.value)}}></input>
                        
                    </div>
                    <p className='error'>{emailError}</p>

                    <div className='formInput'>
                        <span className='passIcon'>
                            <img src={lock} alt='lock'></img>
                        </span>
                        <input type="password" required value={password} placeholder="Password" onChange={(e)=>{setPassword(e.target.value)}}></input>
                        
                    </div>
                    <p className='error'>{passwordError}</p>

                    <button onClick={handleLogIn}>LOG IN</button>
                </div>
            </div>
        </div>
    </div>
  )
}

export default Login;