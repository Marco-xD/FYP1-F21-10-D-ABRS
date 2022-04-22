import './App.css';
import Navbar from './Components/Navbar';
import Home from './Components/Home';
import About from './Components/About';
import Analytics from './Components/analytics';
import Tools from './Components/Tools';
import Login from './Components/Login';
import Footer from './Components/Footer';

import SalesReport from './Components/SalesReport';
import ProductReport from './Components/ProductReport';
import VendorsReport from './Components/VendorsReport';

import fire from './fire';
import { getAuth, onAuthStateChanged, signInWithEmailAndPassword,signOut } from "firebase/auth";

import {useState,useEffect} from 'react';



function App() {

  const [saleisOpen,salesetisOpen]=useState(false);
  const [productisOpen,productsetisOpen]=useState(false);
  const [vendorisOpen, vendorsetisOpen]=useState(false);

  const [user,setUser]=useState('');
  const [email,setEmail]=useState('');
  const [password,setPassword]=useState('');
  const [emailError,setEmailError]=useState('');
  const [passwordError,setpasswordError]=useState('');

  const [showLogin, setShowLogin]=useState(false);
  const [showLogOut, setShowLogOut]=useState(false);

  const clearInput=()=>{  
    setEmail('');
    setPassword('');
  }

  const clearError=()=>{
    setpasswordError('');
    setEmailError('');
  }

  const auth = getAuth(fire);
  
  
  
  const handleLogIn = async () =>{
    setShowLogin(false);
    clearError();
    try{
      const user = await signInWithEmailAndPassword(auth,email,password);
    }catch(err){
      switch(err.code){
        case "auth/invalid-email":
        case "auth/user-disabled":
        case "auth/user-not-found":
          setEmailError("*Please enter valid email.");
          break;
        case "auth/wrong-password":
          setpasswordError("*Incorrect password");
          break;
      }
    }
  }

  const handleLogOut=()=>{
    setShowLogOut(false);
    signOut(auth);
  }

  
  useEffect(()=>{
    onAuthStateChanged(auth,(user)=>{
      if(user){
        setUser(user);
      }else{
        setUser('');
      }
    })},[])

  return (
    <div className="App">

        {showLogin ? (

          <Login handleLogOut={handleLogOut} showLogin={showLogin} setShowLogin={setShowLogin} email={email} setEmail={setEmail} password={password} setPassword={setPassword} handleLogIn={handleLogIn} emailError={emailError} passwordError={passwordError}/>
        ): (
          <>
          {user ? (
            <>
              <Navbar showLogOut={showLogOut} setShowLogOut={setShowLogOut} handleLogOut={handleLogOut} setShowLogin={setShowLogin}/>
              <Home/>
              <About/>
              <Tools />
              <Analytics salesetisOpen={salesetisOpen} productsetisOpen={productsetisOpen} vendorsetisOpen={vendorsetisOpen}/>
              <Footer/>
            </>
          ) : (
            <>
            <Navbar showLogOut={showLogOut} setShowLogOut={setShowLogOut} handleLogOut={handleLogOut} setShowLogin={setShowLogin}/>
            <Home/>
            <About/>
            <Tools />
            <Footer/>
            </>
          )}
          </>
        )}
        
      
        {saleisOpen && <SalesReport salesetisOpen={salesetisOpen}/>}
        {productisOpen && <ProductReport productsetisOpen={productsetisOpen}/>}
        {vendorisOpen && <VendorsReport vendorsetisOpen={vendorsetisOpen}/>}
    </div>
  );
}

export default App;
