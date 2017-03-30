# Blue Mirror


![alt text](https://github.com/adamcreed/Blue-Mirror/blob/master/public/images/blue-mirror-logo.png "A coping tool for those with depression and anxiety")

A coping tool for those with depression and anxiety. This Angular-Rails web application takes on a mobile-first design approach and focuses on promoting mindfulness and self-motivation when life gets hard. Users can track moods over a long period of time as well as keep up with medications and view counselors in their local area.


View Our App on Heroku: https://blue-mirror.herokuapp.com/#!/login

Follow us on Twitter: https://twitter.com/BlueMirrorApp

# Features

* Google & Facebook login

* SMS messaging

* Updating moods

* Customizing moods

* Mood chart

* Personal journal

* Local health centers

* Crisis helplines

* Doables list

* Medication input

* Calendar events

---

###  * Google/Facebook signin
  * Users have the option to sign in using Facebook or Google using OAuth.
  
###  * SMS messaging
  * Users can opt in to receive sms messaging reminders from the Blue Mirror Team using Rails gem SMS-Easy. User's provide their phone number, carrier, and frequency for when they want to receive their sms reminders. Data and information is encrypted using OpenSSL.
  
 ###  * Updating moods
 * Upon entering the user profile, there is an option to update your mood, in which you can choose from our five premade selections or customize your own.
 
 ###  * Customizing moods
 * Choosing to customize your moods will allow you to edit any of our premade mood selections or add more of your very own. You can also sort your moods by dragging and dropping the order in which you want to place your moods using Jquery-UI. Note that editing and deleting moods will reflect on your mood chart.
 
  ###  * Mood chart
  * After updating your moods, they become reflected on the mood chart which displays a collection of the moods submitted. These can be filtered by the past week, month, and six months. This was integrated using Chart.js
  
  
  ### * Personal journal 
  * This feature allows users to write about their day and express their thoughts. They can add tags to their entries, search for specific tags, view past entries, delete, and edit entries as well.
  
  
  ###  * Local Health Centers
  * Local mental health centers nearest you can be located using Google Maps Places and Angular-Google-Maps while utilizing Geolocation. Contact information is also provided for each of those local centers.
  
  ###  * Crisis helplines
   * We provide a list of crisis helplines with a variety of options that may suit the users needs. All of the contact information for each of those helplines are provided.
    
  ### * Doables list
   * This feature provides the user with doable taks to help motivate them, and if they aren't sure what to write, we provide a list of suggested doable tasks that were curated from us and Eponis Sinope. 
    
  ###  * Medication input
  * Users can input and remove current medication their taking. There is a button labeled "I took my meds today" which serves a trackable history on their calendar of the days that their medication was taken while also serving as a visual reminder for the days that they may have forgotten to take it. 

 ###  * Calendar events
 * This feature allows users to add and remove events to and from their calendar using Angular-UI-Calendar and FullCalendar to serve as reminders for upcoming doctor appointments and miscellaneous activities. 
