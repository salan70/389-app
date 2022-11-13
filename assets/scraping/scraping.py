from cgitb import html
from os import link
from re import I
from turtle import title
from urllib.request import urlopen
from urllib.error import HTTPError
from bs4 import BeautifulSoup
import os
import pandas as pd
import re
import time
import datetime
import uuid

class Scraping:

    # 「日本のプロ野球選手一覧」ページから、各球団の「〇〇（球団名）の選手一覧」ページに遷移する
    # ↓「日本のプロ野球選手一覧」ページ
    # https://ja.wikipedia.org/wiki/%E6%97%A5%E6%9C%AC%E3%81%AE%E3%83%97%E3%83%AD%E9%87%8E%E7%90%83%E9%81%B8%E6%89%8B%E4%B8%80%E8%A6%A7
    def visit_team_urls(self, url):
        print('start!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!')

        hitter_basic_df = pd.DataFrame()
        hitter_data_df = pd.DataFrame()

        try:
            html = urlopen(url=url)
        except HTTPError as e:
            return e

        try:
            bs = BeautifulSoup(html, 'html.parser')
            # league_list = ['セントラル・リーグ', 'パシフィック・リーグ']
            league_list = ['パシフィック・リーグ']
            teams = []
            for league in league_list:
                teams += bs.find('div', {'id': 'bodyContent'}).find(
                    'span', {'id': league}).parent.next_sibling.next_sibling.find_all('a')

            for team in teams:
                print(team.get_text(), '============================')
                team_name = team.get_text().replace('の選手一覧', '')
                team_url = team.attrs['href']

                new_hitter_basic_df, new_hitter_data_df = self.__visit_player_url(url=team_url, team=team_name)
                # dfへの追加
                hitter_basic_df = pd.concat([hitter_basic_df, new_hitter_basic_df])
                hitter_data_df = pd.concat([hitter_data_df, new_hitter_data_df])

                time.sleep(2)

            now_dt = datetime.datetime.now()
            output_datetime = f'{now_dt.year}-{now_dt.month}-{now_dt.day} {now_dt.hour}:{now_dt.minute}'
            
            # csvファイルを格納するフォルダを作成
            os.makedirs(f'csv/{output_datetime}')

            # csvへの変換、書き出し
            hitter_basic_df.to_csv(f'csv/{output_datetime}/p_league_hitter_basic.csv')
            hitter_data_df.to_csv(f'csv/{output_datetime}/p_league_hitter_data.csv')

        except AttributeError as e:
            return e

        return None

    # 各球団の「〇〇（球団名）の選手一覧」ページから、選手の表をポジションごとに取得する？
    def __visit_player_url(self, url, team):
        hitter_basic_df = pd.DataFrame()
        hitter_data_df = pd.DataFrame()

        # pos_list = ['投手', '捕手', '内野手', '外野手']
        # pos_list = ['捕手', '内野手', '外野手']
        pos_list = ['捕手']
        for pos in pos_list:
            new_hitter_basic_df, new_hitter_data_df = self.__crawl_player_per_pos(url=url, pos=pos, team=team)
            
            # dfへの追加
            hitter_basic_df = pd.concat([hitter_basic_df, new_hitter_basic_df])
            hitter_data_df = pd.concat([hitter_data_df, new_hitter_data_df])
   
            print('~~~~~~~~~~~~~~  this position is finish ~~~~~~~~~~~~~~~')

        return hitter_basic_df, hitter_data_df

    # 各球団の「〇〇（球団名）の選手一覧」の選手の表から、各選手のページに遷移し、各選手の成績のdataFrameを連結したものを返す
    def __crawl_player_per_pos(self, url, pos, team):
        hitter_basic_df = pd.DataFrame(
            columns=['id', 'name', 'team', 'has_data'], index=[])
        hitter_data_df = pd.DataFrame()

        try:
            html = urlopen('https://ja.wikipedia.org{}'.format(url))
        except HTTPError as e:
            return e

        try:
            bs = BeautifulSoup(html, 'html.parser')
            players = bs.find('div', {'id': 'bodyContent'}).find(
                'span', {'id': pos}).parent.next_sibling.next_sibling.find_all('a')

            for player in players:
                player_url = player.attrs['href']
                player_id = uuid.uuid4()

                new_hitter_data_df = self.__get_hitter_data(url=player_url, player_id=player_id)

                # hitter_basic_dfにinsert
                player_name = player.get_text()
                has_data = type(new_hitter_data_df) is pd.DataFrame

                # hitter_basic_df = hitter_basic_df.append({'id': player_id, 'name': player_name, 'team': team, 'has_data': has_data}, ignore_index=True)
                new_hitter_basic_df = pd.DataFrame({'id': player_id, 'name': player_name, 'team': team, 'has_data': has_data}, index=[0])
                hitter_basic_df = pd.concat([hitter_basic_df, new_hitter_basic_df])

                # hitter_data_dfにinsert
                if has_data == True:
                    hitter_data_df = pd.concat([hitter_data_df, new_hitter_data_df])

                print('----------------', player_name, ' is finish ----------------')
                time.sleep(2)

            return (hitter_basic_df, hitter_data_df)

        except AttributeError as e:
            print('attributeError in __crawl_player_per_pos:', e)

    # 各選手のページから打撃成績を取得し、取得した打撃成績のdataFrameを返す
    def __get_hitter_data(self, url, player_id):
        try:
            # '犠':犠打や犠飛の犠
            # 野手の成績を取得するために設定（wikipediaの表だと犠と打の間に改行が入るため、1文字で指定）
            search_word = '犠'

            df = pd.read_html(
                'https://ja.wikipedia.org{}'.format(url), match=search_word, header=None)[0]

            return self.__format_hitter_data(df=df, player_id=player_id)
        except:
            return None

    def __format_hitter_data(self, df, player_id):
        df['player_id'] = player_id
        return df

scraping = Scraping()
teams = scraping.visit_team_urls(
    url='https://ja.wikipedia.org/wiki/%E6%97%A5%E6%9C%AC%E3%81%AE%E3%83%97%E3%83%AD%E9%87%8E%E7%90%83%E9%81%B8%E6%89%8B%E4%B8%80%E8%A6%A7')
