// // Import the functions you need from the SDKs you need
// import { initializeApp } from "firebase/app";
// import { getAnalytics } from "firebase/analytics";
// // TODO: Add SDKs for Firebase products that you want to use
// // https://firebase.google.com/docs/web/setup#available-libraries

// // Your web app's Firebase configuration
// // For Firebase JS SDK v7.20.0 and later, measurementId is optional
// const firebaseConfig = {
//   apiKey: "AIzaSyAbqW7X77MZBrVI5I2CJd0GfQQJ2uhfH0c",
//   authDomain: "podium-78b4e.firebaseapp.com",
//   projectId: "podium-78b4e",
//   storageBucket: "podium-78b4e.appspot.com",
//   messagingSenderId: "158576154553",
//   appId: "1:158576154553:web:a4881527ce2a9684bb8868",
//   measurementId: "G-NG6RZE5X1N"
// };

// // Initialize Firebase
// const app = initializeApp(firebaseConfig);
// const analytics = getAnalytics(app);

const partnershipsButton = document.querySelector('.partnerships-button');
const partnershipsModal = document.querySelector('.partnerships-modal');
const closeModalIcon = document.querySelector('.x-container');
const partnershipsForm = document.querySelector('modal-form');


const showPartnershipsModal = () => {
    partnershipsModal.style.display = "block";
    setTimeout(() => {
      partnershipsModal.style.opacity = 1;
    }, 0);
};

partnershipsButton.addEventListener('click', showPartnershipsModal)

closeModalIcon.onclick = function() {
  partnershipsModal.style.display = "none";
  partnershipsModal.style.opacity = 0;

}

window.onclick = function(event) {
  if (event.target == partnershipsModal) {
    partnershipsModal.style.display = "none";
    partnershipsModal.style.opacity = 0;

  }
}