# ==============================================================================
#
# Project			: Final Project Corruption
# Authors   		: Fauzi Insan Estiko
# Date created		: Nov 22
# Purpose           : Scraping topic on Twitter
# ==============================================================================


# PACKAGES ------------------------------------------------------------------
from bs4 import BeautifulSoup
import pandas as pd
from selenium import webdriver
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
from selenium.common.exceptions import TimeoutException
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities
import time
import json
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.chrome.service import Service
from twitter_scraper_selenium import scrape_keyword


polsek_palmerah = scrape_keyword(keyword="polsek palmerah", browser="chrome",
                      tweets_count=2000,output_format="csv" ,until="2022-12-1", since="2022-11-24", filename='/Users/fauziestiko/Documents/Cornell/sem 1/corruption/database/polsek_palmerah.csv')

vbpm = scrape_keyword(keyword="viral dulu pemerintah", browser="chrome",
                      tweets_count=5000,output_format="csv" ,until="2022-12-1", since="2018-01-01", filename='/Users/fauziestiko/Documents/Cornell/sem 1/corruption/database/vbpm.csv')

rs_bandung = scrape_keyword(keyword="rs bandung medan", browser="chrome",
                      tweets_count=2000,output_format="csv" ,until="2022-12-1", since="2022-11-07", filename='/Users/fauziestiko/Documents/Cornell/sem 1/corruption/database/rs_bandung.csv')

jalan_jakarta = scrape_keyword(keyword="ubah nama jalan jakarta", browser="chrome",
                      tweets_count=2000,output_format="csv" ,until="2022-12-1", since="2022-05-01", filename='/Users/fauziestiko/Documents/Cornell/sem 1/corruption/database/jalan_jakarta.csv')

palangkaraya_cafe  = scrape_keyword(keyword="palangkaraya cafe lgbt", browser="chrome",
                      tweets_count=2000,output_format="csv" ,until="2022-12-1", since="2022-08-01", filename='/Users/fauziestiko/Documents/Cornell/sem 1/corruption/database/palangkaraya_lgbt.csv')

satpam_shopee = scrape_keyword(keyword="satpam shopee", browser="chrome",
                      tweets_count=2000,output_format="csv" ,until="2022-12-1", since="2022-10-06", filename='/Users/fauziestiko/Documents/Cornell/sem 1/corruption/database/satpam_shopee.csv')


percuma_polisi = scrape_keyword(keyword="#PercumaLaporPolisi", browser="chrome",
                      tweets_count=2000,output_format="csv" ,until="2022-12-1", since="2018-01-01", filename='/Users/fauziestiko/Documents/Cornell/sem 1/corruption/database/percuma_polisi.csv')

bripda_bagus = scrape_keyword(keyword="bripda randy bagus", browser="chrome",
                      tweets_count=2000,output_format="csv" ,until="2022-12-1", since="2021-01-01", filename='/Users/fauziestiko/Documents/Cornell/sem 1/corruption/database/bripda_bagus.csv')

polsek_rudi = scrape_keyword(keyword="aipda rudi  polsek pulogadung", browser="chrome",
                      tweets_count=2000,output_format="csv" ,until="2022-12-1", since="2021-10-01", filename='/Users/fauziestiko/Documents/Cornell/sem 1/corruption/database/polsek_rudi.csv')

kpi_bully = scrape_keyword(keyword="kpi bully", browser="chrome",
                      tweets_count=2000,output_format="csv" ,until="2022-12-1", since="2021-08-01", filename='/Users/fauziestiko/Documents/Cornell/sem 1/corruption/database/kpi_bully.csv')
oknum = scrape_keyword(keyword="#satuharisatuoknum", browser="chrome",
                      tweets_count=2000,output_format="csv" ,until="2022-12-1", since="2018-01-01", filename='/Users/fauziestiko/Documents/Cornell/sem 1/corruption/database/satu_oknum.csv')



'''
key='polsek palmerah'
xurl= 'https://twitter.com/search?q={}&src=typed_query'.format(key)
headers = {
    'user-agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.0.0 Safari/537.36'
    }

driver=webdriver.Chrome(executable_path='/Users/fauziestiko/Desktop/chromedriver')
driver.get(xurl)
#wait for turn on notification pop-up sign
WebDriverWait(driver, 60).until(EC.element_to_be_clickable((By.XPATH, "//div[@class='css-18t94o4 css-1dbjc4n r-1niwhzg r-sdzlij r-1phboty r-rs99b7 r-1wzrnnt r-19yznuf r-64el8z r-1ny4l3l r-1dye5f7 r-o7ynqc r-6416eg r-lrvibr']"))) 

#close the pop-up sign
driver.find_element(by=By.XPATH, value="//div[@class='css-18t94o4 css-1dbjc4n r-1niwhzg r-sdzlij r-1phboty r-rs99b7 r-1wzrnnt r-19yznuf r-64el8z r-1ny4l3l r-1dye5f7 r-o7ynqc r-6416eg r-lrvibr']").click()

driver.execute_script("window.scrollTo(0, 1000);")

time.sleep(5)

dx=[]


soup=BeautifulSoup(driver.page_source,'html.parser')
items=soup.findAll('div',attrs={'data-testid':'cellInnerDiv'}) 
for it in items:
    name=it.find('span', 'css-901oao css-16my406 r-poiln3 r-bcqeeo r-qvutc0')
    time=it.find('time',attrs={'class': None})
    replies=it.find_all('span', 'css-901oao css-16my406 r-poiln3 r-bcqeeo r-qvutc0')[0].text
    retweets=it.find_all('span','css-901oao css-16my406 r-poiln3 r-bcqeeo r-qvutc0')[1].text
    love=it.find_all('span', 'css-901oao css-16my406 r-poiln3 r-bcqeeo r-qvutc0')[2].text
    dx.append([name, time, replies, retweets, love])
    print(name, time, replies, retweets, love)


'''


