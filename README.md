# Data-Analysis-Portfolio

## About Me

Hi, I'm Arthur! I have an education background in Physics and a diverse range of professional experience. As a Data Analyst and passionate reflexive learner, I constantly seek to acquire new skills and take on challenges in line with my core values and ambitions. Inquisitive by nature, I am interested in both systems and people and recognize that human beings are story orientated creatures. My vision is to bridge the gap between the two, leveraging my Data Analysis acumen and interpersonal skills to tell stories with data, describing and uncovering the hidden areas where true value resides. 

Drawing from my diverse, worldly experience, I bring a problem focused, person orientated perspective to the table. Whether racing across Cairo to gather Cost-of-Living data, interviewing locals about black market currency exchange in Sri Lanka or researching hyperinflation in Turkey, I am intrepid in my desire to get to the root cause of an issue and extract the best outcomes, cutting across cultural barriers in the process. 

Recently enrolled in the Data Analytics Career Accelerator program with the London School of Economics, (LSE), I've learned the language and mindset of a Data Analyst from leading experts in the field and am excitedly looking forward to extracting greater value from data than ever before.

My CV in [pdf](https://github.com/ARHilton/Data-Analysis-Portfolio/blob/main/Arthur%20Hilton_Data%20Analyst_CV.pdf).

This is a repository to showcase skills, share projects and track my progress in Data Analytics / Data Science related topics.

# Table of Contents

- [About Me](#about-me)
- [Porfolio Projects](#portfolio-projects)


## Portfolio Projects

In this section I will list data analytics projects briefly describing the technology stack used to solve cases.

### Supermarket Customer Analysis

**Business Problem:** The supermarket lack an understanding of their customer demographics, the products they purchase and the efficacy of their advertising channels. They also lack understanding of how these forces intersect.

**Presentation:** [pdf](https://github.com/ARHilton/Data-Analysis-Portfolio/blob/main/2Market%20Customer%20Analysis.pdf).
 
**Description:** A project focussed on exploring the customer demographics of a supermarket retailer as well as explaining customer behaviour and their responsivity to different advertisments. The dataset contained several thousand rows of customer data, including customer id, information on age, marriage status, family size, income level, nationality, online/in store preference and the proclivity to respond to adverisements. An additional dataset included a record of advertisements served via different mediums (mail/X/Instagram/Facebook). The data was initially cleaned and explored using Excel, further wrangled and explored using PostgreSQL and finally loaded into Tableau. Several dashboard were created to answer key business questions related to the problem statement.

**Skills:** Data cleaning, dealing with outliers, exploratory analysis, structured thinking frameworks, formulating a problem statement, creating visualisations, presenting insights and recommendations.

**Technology:** Excel, PostgreSQL, Tableau.

**Results:** Presented a range of business recommendations, including:
- The Customer: I advised the supermarket to foster relationships with those in their thirties and to sell to those between 45 and 75. Couples and families were the most lucrative demographic.
- The product: I recommended focussing in on two categories of item, as these were the most popular, regardless of country or online/in store.
- Advertisements: Presented insights around which advert mediums are most successful with each demographic, especially around age, education and family size.

### NHS Capacity Analysis

**Business Problem:** The NHS has finite resources. In order to meet patient demand, the NHS must ascertain whether capacity must be expanded, or whether demand can be met by reallocating existing resources.

**Code:**

**Presentation:**

**Description:** The project sought to answer the question, "if NHS capacity was sufficient, what would it look like?", by drawing from NHS targets, namely: seeing patients within 14 days of booking, allocating 15 minutes per patient consultation and for attendance to be as high as possible. The dataset contained several hundred thousand rows of appointment data, ranging from January 2020 to June 2022 and included information on ICB (locality), consultation types and attendance. The data was cleaned and wrangled using the numpy Python library, and visualisations created using seaborn and matplotlib.

**Skills:** Data cleaning & wrangling, exploratory & descriptive analysis, structured thinking frameworks, formulating a problem statement, creating visualisations, presenting insights and recommendations.

**Technology:** Python: Pandas, Numpy, Seaborn, Matplotlib.

**Results:** Presented a range of insights and recommendations, supported by visualisations, namely:
- Patients were generally seen within 14 days and attended appointments at a very high rate. The main area of failure was appointment time allocated to each patient, symptomatic of a lack of staff.
- Adjusting the modality of appointments, depending on lag time between booking and consultation, to increase chance of attendance. Telephone consultations are well attended regardless of lag time.
- Attendance rate was greater in ICBs with fewer resources, suggesting an awareness and respect among the public for NHS resources.
             
### Console Games Retailer Analysis

**Problem Statement:** How can the retailer use existing data to predict customer behaviour and promote engaement?

**Code:**

**Presentation:** 

**Description:** 

**Skills:**

**Technology:**

**Results:** Presented a range of insights and recommendations, supported by visualisations, namely:
- Customers could be classified as engagers (those that accumilate loyalty points), non-engagers (those that don't) and 'seeds' (those who have not yet become either).
- How to tailor communications with different customers, according to their income level and spending habits, in order to foster engagement.  
- The polarity of sentiment expressed in reviews, as well as the most frequently occurring words.
- An overview of sales performance across various regions, especially focussing on the prevelance of outliers in unique title sales and the overall decline post 2010, indicative of a shifting market and supporting a recommendation to explore new technologies and markets outside of console games.
- Demonstrated the power of predictive modelling, using North American and European sales, to predict overall sales.

### Bank of England Speech Sentiment Analysis

**Problem Statement:** Does speech sentiment effectively limit shock?

**Code:**

**Presentation:** [Group presentation slide deck.](https://github.com/ARHilton/Data-Analysis-Portfolio/blob/main/Team10_LSE_EP_Assignment3_presentation_slides.pdf)

**Description:** I led a team of six people in a project exploring the sentiments expressed by the Bank of England (BoE) in their speeches. The aim of the project was to illuminate relationships between speech sentiments and key econominc indicators, and to validate whether the sentiments expressed are an effective form of 'soft influence' for the bank, specifically in limiting ecomonic shock. The basis of the sentiment analysis was a wordlist, provided by BoE, and itself based on [previous research](https://www.jstor.org/stable/43862267), similar in nature. The wordlist contianed 3880 words, each of which were classified as belonging to one or more of a possible seven sentiments, with several instances of overlap. Additionally, a dataset of speeches delivered by BoE was provided, which included information on the speaker, their governer status, a dictation of the entire speech and the data it was delivered. Speeches were analysed agaisnt the wordlist, deriving a score for each of the seven sentiments. These scores were then normalised for length to facilitate fair comparisson. Various aspect of the project were delegated, including the initial data cleaning and sentiment analysis. Beyond a leadership role, my contribution included analysing sentiment mean and standard deviation agaisnt bank rates, unity in the rate voting committee and historical events. I additionally examined the use of sentiment between the 'mini-budget' of 2022 and the 'spring budget' of 2023.

**Skills:** Team leadership & support, communication, data wrangling,  

**Technology:** Python

**Results:** Across two group presentations, I delivered a range of insights and recommendations to BoE, namely:
- 'Uncertain' sentiment reacted sharply to the 2008 financial crash.
- Unprecedented levels of disunity among the rate voting committee does not seem to have 'leaked' into the sentiment of speeches, indicating coherent public facing messaging.
- 'Constraining' & 'litigious' sentiments were expressed simultaneously, albeit in different ways, and in tandem with the hard control of rasing interest rates, between the 'mini budget' and 'spring budget', to arrest the economic shock being felt by the UK economy.
