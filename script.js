{\rtf1\ansi\ansicpg950\cocoartf2709
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 :root \{\
    --primary-blue: #1A2B4C; /* \uc0\u28145 \u34253 \u33394  */\
    --accent-gold: #DAA520; /* \uc0\u37329 \u33394  */\
    --white: #FFFFFF;\
    --light-gray: #F8F8F8;\
    --text-dark: #333333;\
    --text-light: #666666;\
\}\
\
* \{\
    box-sizing: border-box;\
    margin: 0;\
    padding: 0;\
\}\
\
body \{\
    font-family: 'Noto Sans TC', sans-serif;\
    line-height: 1.6;\
    color: var(--text-dark);\
    background-color: var(--white);\
    -webkit-font-smoothing: antialiased;\
    -moz-osx-font-smoothing: grayscale;\
\}\
\
.container \{\
    max-width: 100%;\
    margin: 0 auto;\
    padding: 0 15px;\
\}\
\
section \{\
    padding: 60px 0;\
    text-align: center;\
\}\
\
section:nth-of-type(even) \{\
    background-color: var(--light-gray);\
\}\
\
h1, h2, h3 \{\
    color: var(--primary-blue);\
    margin-bottom: 20px;\
    font-weight: 700;\
\}\
\
h1 \{\
    font-size: 2.2em;\
    line-height: 1.3;\
\}\
\
h2 \{\
    font-size: 1.8em;\
    margin-bottom: 30px;\
\}\
\
h3 \{\
    font-size: 1.4em;\
    margin-bottom: 15px;\
\}\
\
p \{\
    margin-bottom: 15px;\
    color: var(--text-light);\
\}\
\
.btn \{\
    display: inline-block;\
    background-color: var(--accent-gold);\
    color: var(--white);\
    padding: 12px 30px;\
    border-radius: 5px;\
    text-decoration: none;\
    font-weight: 700;\
    transition: background-color 0.3s ease;\
    border: none;\
    cursor: pointer;\
    font-size: 1em;\
\}\
\
.btn:hover \{\
    background-color: #C4911A; /* Slightly darker gold */\
\}\
\
/* Hero Banner */\
#hero \{\
    background: url('https://via.placeholder.com/1200x600/1A2B4C/FFFFFF?text=Professional+Business+Meeting' ) no-repeat center center/cover;\
    color: var(--white);\
    padding: 100px 15px;\
    display: flex;\
    flex-direction: column;\
    justify-content: center;\
    align-items: center;\
    min-height: 60vh;\
    position: relative;\
\}\
\
#hero::before \{\
    content: '';\
    position: absolute;\
    top: 0;\
    left: 0;\
    right: 0;\
    bottom: 0;\
    background: rgba(0, 0, 0, 0.5); /* Dark overlay */\
    z-index: 1;\
\}\
\
#hero .hero-content \{\
    position: relative;\
    z-index: 2;\
    max-width: 800px;\
\}\
\
#hero h1 \{\
    color: var(--white);\
    font-size: 2.5em;\
    margin-bottom: 10px;\
\}\
\
#hero .sub-headline \{\
    font-size: 1.2em;\
    margin-bottom: 30px;\
    color: rgba(255, 255, 255, 0.9);\
\}\
\
.icon-overlay \{\
    display: flex;\
    justify-content: center;\
    gap: 30px;\
    margin-top: 30px;\
\}\
\
.icon-overlay .icon-item \{\
    background-color: rgba(255, 255, 255, 0.15);\
    border-radius: 50%;\
    width: 60px;\
    height: 60px;\
    display: flex;\
    justify-content: center;\
    align-items: center;\
    font-size: 1.8em;\
    color: var(--accent-gold);\
    border: 2px solid var(--accent-gold);\
\}\
\
/* Pain Section */\
.pain-points \{\
    display: flex;\
    flex-direction: column;\
    gap: 30px;\
    margin-top: 40px;\
\}\
\
.pain-point-item \{\
    display: flex;\
    align-items: center;\
    gap: 20px;\
    text-align: left;\
    background-color: var(--white);\
    padding: 20px;\
    border-radius: 8px;\
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);\
\}\
\
.pain-point-item i \{\
    font-size: 2.5em;\
    color: var(--primary-blue);\
    min-width: 50px;\
    text-align: center;\
\}\
\
.pain-point-item p \{\
    margin: 0;\
    font-size: 1.1em;\
    color: var(--text-dark);\
\}\
\
/* Gain Section */\
.gain-content \{\
    display: flex;\
    flex-direction: column;\
    align-items: center;\
    gap: 40px;\
    margin-top: 40px;\
\}\
\
.infographic-placeholder \{\
    width: 100%;\
    max-width: 600px;\
    height: 300px;\
    background-color: #e0e0e0;\
    border-radius: 8px;\
    display: flex;\
    justify-content: center;\
    align-items: center;\
    color: var(--text-light);\
    font-size: 1.1em;\
    text-align: center;\
    padding: 20px;\
\}\
\
.team-highlight \{\
    font-size: 1.1em;\
    font-weight: 700;\
    color: var(--primary-blue);\
    margin-top: 20px;\
\}\
\
/* Proof Section */\
.proof-flow \{\
    display: flex;\
    flex-direction: column;\
    align-items: center;\
    gap: 20px;\
    margin-top: 40px;\
\}\
\
.flow-step \{\
    background-color: var(--primary-blue);\
    color: var(--white);\
    padding: 15px 25px;\
    border-radius: 5px;\
    font-weight: 700;\
    font-size: 1.1em;\
    width: fit-content;\
\}\
\
.flow-arrow \{\
    font-size: 1.5em;\
    color: var(--primary-blue);\
\}\
\
.case-study-warning \{\
    background-color: #FFF3E0; /* Light orange background */\
    border-left: 5px solid #FFC107; /* Orange border */\
    padding: 20px;\
    margin: 30px auto;\
    border-radius: 5px;\
    max-width: 700px;\
    text-align: left;\
    color: #333;\
    font-size: 0.95em;\
\}\
\
.case-studies \{\
    display: flex;\
    flex-direction: column;\
    gap: 30px;\
    margin-top: 40px;\
\}\
\
.case-card \{\
    background-color: var(--white);\
    padding: 30px;\
    border-radius: 8px;\
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);\
    text-align: left;\
\}\
\
.case-card h3 \{\
    color: var(--accent-gold);\
    margin-bottom: 10px;\
\}\
\
.case-card strong \{\
    color: var(--primary-blue);\
\}\
\
/* Benefit Section */\
.comparison-table \{\
    width: 100%;\
    max-width: 700px;\
    margin: 40px auto;\
    border-collapse: collapse;\
    text-align: left;\
\}\
\
.comparison-table th, .comparison-table td \{\
    padding: 12px 15px;\
    border: 1px solid #ddd;\
\}\
\
.comparison-table th \{\
    background-color: var(--primary-blue);\
    color: var(--white);\
    font-weight: 700;\
\}\
\
.comparison-table td:first-child \{\
    font-weight: 700;\
    color: var(--primary-blue);\
\}\
\
.summary-text \{\
    font-size: 1.1em;\
    font-weight: 700;\
    color: var(--primary-blue);\
    margin-top: 30px;\
\}\
\
/* Value-Add Section */\
.course-modules \{\
    display: flex;\
    flex-direction: column;\
    gap: 20px;\
    margin-top: 40px;\
\}\
\
.module-item \{\
    display: flex;\
    align-items: center;\
    gap: 15px;\
    background-color: var(--white);\
    padding: 20px;\
    border-radius: 8px;\
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);\
    text-align: left;\
\}\
\
.module-item i \{\
    font-size: 2em;\
    color: var(--accent-gold);\
    min-width: 40px;\
    text-align: center;\
\}\
\
.module-item p \{\
    margin: 0;\
    font-size: 1.05em;\
    color: var(--text-dark);\
\}\
\
.community-text \{\
    font-size: 1.1em;\
    font-weight: 700;\
    color: var(--primary-blue);\
    margin-top: 30px;\
\}\
\
/* Registration Form */\
#registration \{\
    background-color: var(--primary-blue);\
    color: var(--white);\
    padding: 60px 15px;\
\}\
\
#registration h2 \{\
    color: var(--white);\
\}\
\
.registration-form \{\
    max-width: 500px;\
    margin: 40px auto 0;\
    background-color: var(--white);\
    padding: 30px;\
    border-radius: 8px;\
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);\
    text-align: left;\
\}\
\
.form-group \{\
    margin-bottom: 20px;\
\}\
\
.form-group label \{\
    display: block;\
    margin-bottom: 8px;\
    font-weight: 700;\
    color: var(--text-dark);\
\}\
\
.form-group input[type="text"],\
.form-group input[type="tel"] \{\
    width: 100%;\
    padding: 12px;\
    border: 1px solid #ddd;\
    border-radius: 5px;\
    font-size: 1em;\
    color: var(--text-dark);\
\}\
\
.form-group input::placeholder \{\
    color: #aaa;\
\}\
\
.privacy-disclaimer \{\
    font-size: 0.85em;\
    color: var(--text-light);\
    margin-top: 20px;\
    text-align: center;\
\}\
\
#form-message \{\
    margin-top: 20px;\
    padding: 15px;\
    border-radius: 5px;\
    display: none; /* Hidden by default */\
    text-align: center;\
    font-weight: 700;\
\}\
\
#form-message.success \{\
    background-color: #D4EDDA;\
    color: #155724;\
    border: 1px solid #C3E6CB;\
\}\
\
#form-message.error \{\
    background-color: #F8D7DA;\
    color: #721C24;\
    border: 1px solid #F5C6CB;\
\}\
\
/* Responsive adjustments */\
@media (min-width: 768px) \{\
    h1 \{\
        font-size: 3em;\
    \}\
    h2 \{\
        font-size: 2.5em;\
    \}\
    .container \{\
        padding: 0 30px;\
    \}\
    .pain-points, .case-studies, .course-modules \{\
        flex-direction: row;\
        flex-wrap: wrap;\
        justify-content: center;\
    \}\
    .pain-point-item, .case-card, .module-item \{\
        flex: 1 1 calc(50% - 30px); /* Two columns */\
        max-width: calc(50% - 30px);\
    \}\
    .proof-flow \{\
        flex-direction: row;\
        justify-content: center;\
    \}\
    .flow-arrow \{\
        margin: 0 15px;\
    \}\
\}\
\
@media (min-width: 1024px) \{\
    h1 \{\
        font-size: 3.5em;\
    \}\
    h2 \{\
        font-size: 3em;\
    \}\
    .container \{\
        max-width: 1000px;\
    \}\
    .pain-point-item, .case-card, .module-item \{\
        flex: 1 1 calc(33.333% - 30px); /* Three columns */\
        max-width: calc(33.333% - 30px);\
    \}\
\}\
}