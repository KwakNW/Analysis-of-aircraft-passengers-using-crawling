# Analysis-of-aircraft-passengers-using-crawling
2019년 빅데이터 정보처리 개인 프로젝트

<h5>사용 언어 및 Tool</h5>

- R 3.6.1
- RSelenium

<h5> 분석 이유 및 목적 </h5>
현대 사회가 글로벌 시대로 변화함으로 인해 비행기는 해외로 이동하기에 유용한 교통수단으로 이용되고 있다. 
심지어는 해외뿐만 아니라 국내 또한 출장이나 여행 등의 이동 수단으로 비행기를 이용하는 인원도 증가하고 있다. 이러한 이유로 항공기 시간이나 월별 이용객의 수 등을 분석해보면 유용한 자료로 쓰일 듯하여 분석을 진행

<h5> 분석 종류 </h5>
1. 크롤링 
2. 막대그래프 & 꺾은선 그래프 
3. Donut Pie Chart 
4. Calendar Heat Map 
5. ARIMA를 이용한 예측

<h5> 크롤링 데이터 </h5>
본 데이터는 2017년 1월 1일부터 2019년 11월 19일까지의 항공기 이용객의 수를 아래의 사이트를 통해 크롤링을 하였다. (현재는 페이지가 변경된 것으로 보임)
http://www.airport.co.kr/www/extra/dailyExpect/dailyExpectList/layOut.do?cid=2016053109481920258&menuId=4

![image](https://user-images.githubusercontent.com/68180545/139634164-d55dcdb5-c5d0-46f6-ad3e-d2632c08c9e2.png)

<h5> 변수별 상관관계 </h5>

![각 변수의 상관관계](https://user-images.githubusercontent.com/68180545/139634215-b15aec67-febc-4091-8f47-b8975f352a84.PNG)

<h5> 막대그래프 & 꺾은선 그래프 </h5>

![IN OUT 막대그래프_한번에](https://user-images.githubusercontent.com/68180545/139634394-6560639a-1921-4c93-9911-02ca5a447f91.PNG)
![꺾은선 그래프 Total](https://user-images.githubusercontent.com/68180545/139634304-b78609f1-8ff2-4a81-84d8-fb3d2c6345a4.PNG)
![꺾은선 그래프_In](https://user-images.githubusercontent.com/68180545/139634310-5f29db1a-6415-4405-91ca-29530417be9f.PNG)
![꺾은선 그래프_Out](https://user-images.githubusercontent.com/68180545/139634292-602b4682-3bf9-425b-81f0-b722d98e6a7d.PNG)

<h5> Donut Pie Chart </h5>

![DonutPie_11월 포함](https://user-images.githubusercontent.com/68180545/139634433-f3f9c556-732c-449b-bdb0-5345236136d4.PNG)

<h5> Calendar Heat Map </h5>

![캘린더 히트맵_In](https://user-images.githubusercontent.com/68180545/139634484-e2cb1eb7-f80d-4f12-ba38-825e41f60891.PNG)
![캘린더 히트맵_Out](https://user-images.githubusercontent.com/68180545/139634489-cedc4548-6d7e-442a-9083-c1a77e2a12c1.PNG)
![캘린더 히트맵_Total](https://user-images.githubusercontent.com/68180545/139634494-fd8e27f2-521e-4c51-956b-ce1bf05ef97e.PNG)

<h5> ARIMA </h5>

![ARIMA 안정성검증_Total](https://user-images.githubusercontent.com/68180545/139634604-9c960c7b-eafa-4838-bd2a-7a3e6cbbefb3.PNG)
![ARIMA 전체적인 맥락 PLOT](https://user-images.githubusercontent.com/68180545/139634538-f9fffc30-155c-44a8-b20e-b3447c4a1b30.PNG)
![ARIMA Total 예측 모형](https://user-images.githubusercontent.com/68180545/139634595-e4ccd471-780e-4592-bf21-97a0c004cb1b.PNG)
