## SECTION 1 : PROJECT TITLE
## Music recommendation System
<img src=""
     style="float: left; margin-right: 0px;" />

---

## SECTION 2 : EXECUTIVE SUMMARY / PAPER ABSTRACT


Many users on movie websites will post corresponding comments and ratings after watching a movie. When applied to a recommendation system, movie reviews and scoring analysis are very valuable. These comment information more effectively reflect the user’s opinion of a certain movie. The degree of preference for a movie. When users browse the website to find movies, the website can use this information to recommend some movies that the target user may be interested in, which improves the user experience and helps users find their favorite movies to enjoy in the shortest time. Of course, we can also use some other features like page movie click rate, stay time, etc. to infer the user's preference and attention to the movie.

In the face of such a large amount of information, how do users find the parts they are interested in? The recommendation system should be implemented. And the recommendation system is to recommend information that may be of interest to users according to their interests and hobbies to solve the problem of "information overload" and improve the efficiency of information processing.

In our project, We will create a movie watching website, including movie website, backstage management system, recommendation system.

Users can browse movie information and query movies on the website, and the website will make real-time movie recommendations to the user based on the user's browsing history.

The background management system mainly manages user information and movie information, such as adding and deleting movie information and completing user information.

In the movie website system, the user's click events (such as which movie the user likes or the rating of a certain movie) are obtained and the information is transmitted to the recommendation system, the recommendation system makes corresponding processing based on the information, and recommends The result is stored in the mysql database, and the web front end displays the recommended movie to the user by querying the database

---

## SECTION 3 : CREDITS / PROJECT CONTRIBUTION

| Official Full Name  | Student ID (MTech Applicable)  | Work Items (Who Did What) | Email (Optional) |
| :------------ |:---------------:| :-----| :-----|
| Mingjie XU |  | MovieAdmin Web FE and BE design, Recommendation system design, data crawling, document writing| E@nus.edu.sg |
| Chengyuan Sun | A0180523M | Movie Web FE and BE design,Model build and traing, paper,data crawling, document writing| E0284009@u.nus.edu |

---

## SECTION 4 : VIDEO OF SYSTEM MODELLING & USE CASE DEMO

[![Music Match](Miscellaneous/yotube.png)](https://www.youtube.com/ "Music Match Video")

---

## SECTION 5 : USER GUIDE

### Requirements

1.Install docker 20.10.5 in your computer.

2.Download and unzip 

[dockerMovieRec.zip]: https://drive.google.com/file/d/1Ea7m0OX-maSqXCy68snby8yOhODitCdM/view?usp=sharing



 in C:\temp (create if not existing) on Windows10  or copy into \temp on Linux

3.CD to \MovieRecommend, then run command "docker compose up -d"

4.Open localhost:85/movie/

All dataset and models are integrated with docker images





### Model Checkpoint and data set

Download model_checkpoint from 
Put it in to project code root directory. 

Download project dataset from.

### Guide



---
## SECTION 6 : PROJECT REPORT / PAPER

`Refer to project report at Github Folder: ProjectReport`

**Recommended Sections for Project Report / Paper:**
- Executive Summary / Paper Abstract
- Sponsor Company Introduction (if applicable)
- Business Problem Background
- Market Research
- Project Objectives & Success Measurements
- Project Solution (To detail domain modelling & system design.)
- Project Implementation (To detail system development & testing approach.)
- Project Performance & Validation (To prove project objectives are met.)
- Project Conclusions: Findings & Recommendation
- Appendix of report: Project Proposal
- Appendix of report: Mapped System Functionalities against knowledge, techniques and skills of modular courses: MR, RS, CGS
- Appendix of report: Installation and User Guide
- Appendix of report: 1-2 pages individual project report per project member, including: Individual reflection of project journey: (1) personal contribution to group project (2) what learnt is most useful for you (3) how you can apply the knowledge and skills in other situations or your workplaces
- Appendix of report: List of Abbreviations (if applicable)
- Appendix of report: References (if applicable)

