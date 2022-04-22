
import { initializeApp } from "firebase/app";

const firebaseConfig = {
  apiKey: "AIzaSyCfnxi9rGyb5RHxl7qyHCixPLWZWQmZpw8",
  authDomain: "abrs-fyp.firebaseapp.com",
  projectId: "abrs-fyp",
  storageBucket: "abrs-fyp.appspot.com",
  messagingSenderId: "450389378536",
  appId: "1:450389378536:web:9cc49cd4f1f8452f6fd05d"
};


const fire = initializeApp(firebaseConfig);


export default fire;