from os import link
from re import I
from turtle import title
from urllib.request import urlopen
from urllib.error import HTTPError
from bs4 import BeautifulSoup
import re
import time

def crawl_team(url):
    try:
        html = urlopen(url=url)
    except HTTPError as e:
        return e

    try:
        bs = BeautifulSoup(html, 'html.parser')
        cl_teams = bs.find('div', {'id' : 'bodyContent'}).find('span', {'id' : 'セントラル・リーグ'}).parent.next_sibling.next_sibling.find_all('a')
        pl_teams = bs.find('div', {'id' : 'bodyContent'}).find('span', {'id' : 'パシフィック・リーグ'}).parent.next_sibling.next_sibling.find_all('a')

        all_teams = cl_teams + pl_teams
        for team in all_teams:
            team_url = team.attrs['href']
            crawl_all_player(url=team_url)
            time.sleep(5)

    except AttributeError as e:
        return e

    return None

def crawl_all_player(url):
    pos_list = ['投手', '捕手', '内野手', '外野手']
    for pos in pos_list:
        crawl_player_per_pos(url=url, pos=pos)


def crawl_player_per_pos(url, pos):
    try:
        html = urlopen('https://ja.wikipedia.org{}'.format(url))
    except HTTPError as e:
        return e

    try:
        bs = BeautifulSoup(html, 'html.parser')        
        players = bs.find('div', {'id' : 'bodyContent'}).find('span', {'id' : pos}).parent.next_sibling.next_sibling.find_all('a')
        for player in players:
            # TODO 各選手のページに遷移し、データを取得
            None
    except AttributeError as e:
        return e

    return None

teams = crawl_team(url='https://ja.wikipedia.org/wiki/%E6%97%A5%E6%9C%AC%E3%81%AE%E3%83%97%E3%83%AD%E9%87%8E%E7%90%83%E9%81%B8%E6%89%8B%E4%B8%80%E8%A6%A7')