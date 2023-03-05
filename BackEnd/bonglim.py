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


class BonglimSpider(scrapy.Spider):
    name = 'bonglim'
    start_urls = [
        'https://www.changwon.ac.kr/kor/di/diView/dietView.do?mi=10198&kind=B']

    def parse(self, response):
        i = 1
        idx = 0
        lst = [''] * 25

        path = '//*[@id="sub_content"]/div[2]/div[1]/p[1]/text()'
        with open('./bonglim.json', 'r') as f:
            last_data = json.load(f)

        if (last_data['flag'][0] != response.xpath(path).extract()[0]):
            while (i < 6):
                j = 1
                while (j < 6):
                    path = '//*[@id="sub_content"]/div[2]/div[1]/div[4]/table/tbody/tr[' + \
                        str(j) + ']/td[' + str(i) + ']/text()'
                    lst[idx] = re.sub("\(.*\)|\s-\s.*", '', "\n".join(response.xpath(path).extract(
                    )).replace(" ", "").rstrip("\n")).replace("\r\n\r", "\r").lstrip("\r\n")
                    idx += 1
                    j += 1
                json_data[str(i-1)] = [lst[5 * i - 5], lst[5 * i - 4],
                                       lst[5 * i - 3], lst[5 * i - 2], lst[5 * i - 1]]
                i += 1

            json_data[str(i-1)] = datetime.today().strftime("마지막 업데이트: %m월 %d일")
            path = '//*[@id="sub_content"]/div[2]/div[1]/p[1]/text()'
            json_data[str('flag')] = response.xpath(path).extract()

            with open('bonglim.json', 'w', encoding="utf-8") as make_file:
                json.dump(json_data, make_file,
                          ensure_ascii=False, indent="\t")
            uploadfile = open('./bonglim.json', mode='rb')
            session.encoding = 'utf-8'
            session.storbinary('STOR ' + '/bonglim.json', uploadfile)
            uploadfile.close()
            session.quit()
