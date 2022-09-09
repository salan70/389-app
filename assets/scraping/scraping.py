from cgitb import html
from os import link
from re import I
from turtle import title
from urllib.request import urlopen
from urllib.error import HTTPError
from bs4 import BeautifulSoup
import pandas as pd
import re
import time

class Scraping:

    def crawl_team(self, url):
        try:
            html = urlopen(url=url)
        except HTTPError as e:
            return e

        try:
            bs = BeautifulSoup(html, 'html.parser')
            # league_list = ['セントラル・リーグ', 'パシフィック・リーグ']
            league_list = ['セントラル・リーグ']
            teams = []
            for league in league_list:
                teams += bs.find('div', {'id' : 'bodyContent'}).find('span', {'id' : league}).parent.next_sibling.next_sibling.find_all('a')

            for team in teams:
                # print(team.get_text(), '-------------')
                team_url = team.attrs['href']
                self.__crawl_all_player(url=team_url)
                time.sleep(2)

        except AttributeError as e:
            return e

        return None

    def __crawl_all_player(self, url):
        # pos_list = ['投手', '捕手', '内野手', '外野手']
        pos_list = ['捕手']
        for pos in pos_list:
            self.__crawl_player_per_pos(url=url, pos=pos)


    def __crawl_player_per_pos(self, url, pos):
        try:
            html = urlopen('https://ja.wikipedia.org{}'.format(url))
        except HTTPError as e:
            return e

        try:
            bs = BeautifulSoup(html, 'html.parser')        
            players = bs.find('div', {'id' : 'bodyContent'}).find('span', {'id' : pos}).parent.next_sibling.next_sibling.find_all('a')
            for player in players:
                # print(player.get_text())
                player_url = player.attrs['href']
                self.__get_hitter_data(url=player_url)

                # TODO playersへのinsert
                # TODO 
                time.sleep(2)

        except AttributeError as e:
            return e

        return None

    def __get_hitter_data(self, url):
        try:
            # 'O':OPSのO
            search_word = 'O'
            data_flame = pd.read_html('https://ja.wikipedia.org{}'.format(url), match=search_word)

            # data_flame[0]のほうが良い？
            for data in data_flame:
                print(data)

            # TODO player_idをdfに追加
            # TODO idをdfに追加
            return True
        except:
            return False



scraping = Scraping()
teams = scraping.crawl_team(url='https://ja.wikipedia.org/wiki/%E6%97%A5%E6%9C%AC%E3%81%AE%E3%83%97%E3%83%AD%E9%87%8E%E7%90%83%E9%81%B8%E6%89%8B%E4%B8%80%E8%A6%A7')