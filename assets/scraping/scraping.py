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
                print(team.get_text(), '============================')
                team_url = team.attrs['href']
                self.__crawl_all_player(url=team_url)
                time.sleep(2)

        except AttributeError as e:
            return e

        return None

    def __crawl_all_player(self, url):
        # pos_list = ['投手', '捕手', '内野手', '外野手']
        # pos_list = ['捕手', '内野手', '外野手']
        pos_list = ['捕手']
        for pos in pos_list:
            print('~~~~~~~~~~~~~~ Result ~~~~~~~~~~~~~~~')
            print(self.__crawl_player_per_pos(url=url, pos=pos))
            print('~~~~~~~~~~~~~~ Result ~~~~~~~~~~~~~~~')


    def __crawl_player_per_pos(self, url, pos):
        hitter_data_df = []

        try:
            html = urlopen('https://ja.wikipedia.org{}'.format(url))
        except HTTPError as e:
            return e

        try:
            bs = BeautifulSoup(html, 'html.parser')        
            players = bs.find('div', {'id' : 'bodyContent'}).find('span', {'id' : pos}).parent.next_sibling.next_sibling.find_all('a')
            for player in players:
                print(player.get_text())
                player_url = player.attrs['href']

                # dfにinsert
                hitter_data_df.append(self.__get_hitter_data(url=player_url))

                print('----------------next----------------')
                time.sleep(2)
            
            return hitter_data_df

        except AttributeError as e:
            return e

        return None

    def __get_hitter_data(self, url):
        hitter_data_df = []

        try:
            # '犠':犠打や犠飛の犠
            # 野手の成績を取得するために設定（wikipediaの表だと犠と打の間に改行が入るため、1文字で指定）
            search_word = '犠'

            data_flame = pd.read_html('https://ja.wikipedia.org{}'.format(url), match=search_word ,header=0)

            return data_flame[0]

            # TODO player_idをdfに追加
            # TODO idをdfに追加
            return True
        except:
            return None


scraping = Scraping()
teams = scraping.crawl_team(url='https://ja.wikipedia.org/wiki/%E6%97%A5%E6%9C%AC%E3%81%AE%E3%83%97%E3%83%AD%E9%87%8E%E7%90%83%E9%81%B8%E6%89%8B%E4%B8%80%E8%A6%A7')