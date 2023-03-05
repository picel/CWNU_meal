# -*- coding: utf-8 -*-
import scrapy
import ftplib
import json
import re
from datetime import datetime
from collections import OrderedDict

json_data = OrderedDict()

session = ftplib.FTP()
session.connect('storage.bunnycdn.com', 21)
session.login("uploadDest", "s3cretkey")


class CwnumealSpider(scrapy.Spider):
    name = 'dorm'
    start_urls = [
        'https://www.changwon.ac.kr/dorm/na/ntt/selectNttList.do?mi=10079&bbsId=2918']

    def parse(self, response):
        i = 3
        idx = 0
        j = [3, 5, 8]
        lst = []
        lst = [''] * 21

        with open('./dorm.json', 'r') as f:
            last_data = json.load(f)

        if (last_data['flag'][0] == response.xpath('//*[@id="nttViewForm"]/div[1]/table/tbody/tr[1]/th/text()').extract()[0] and last_data['7'] != datetime.today().strftime("마지막 업데이트: %m월 %d일")):
            for i in range(7):
                for j in range(3):
                    lst[j] = "식단 정보 업데이트 대기중"
                json_data[i] = [lst[j-2], lst[j-1], lst[j]]
            json_data['flag'] = [last_data['flag'][0]]
            json_data['7'] = last_data['7']
        else:
            while (i < 10):
                for k in j:
                    if k == 9:
                        tdi = str(i - 1)
                    else:
                        tdi = str(i)
                    path = '//*[@id="nttViewForm"]/div[1]/table/tbody/tr[' + \
                        str(k) + ']/td[' + tdi + ']/text()'
                    lst[idx] = re.sub("\(.*\)|\s-\s.*", '', "\n".join(response.xpath(path).extract(
                    )).replace(" ", "").rstrip("\r\n")).replace("\r\n\r", "\r").rstrip("\r\n")
                    idx += 1
                json_data[str(i-3)] = [lst[idx-3], lst[idx-2], lst[idx-1]]
                i += 1
            json_data[str(i-3)] = datetime.today().strftime("마지막 업데이트: %m월 %d일")
            json_data[str('flag')] = response.xpath(
                '//*[@id="nttViewForm"]/div[1]/table/tbody/tr[1]/th/text()').extract()
        with open('dorm.json', 'w', encoding="utf-8") as make_file:
            json.dump(json_data, make_file, ensure_ascii=False, indent="\t")
        uploadfile = open('./dorm.json', mode='rb')
        session.encoding = 'utf-8'
        session.storbinary('STOR ' + '/dorm.json', uploadfile)
        uploadfile.close()
        session.quit()
