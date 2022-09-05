from os import link
from re import I
from turtle import title
from urllib.request import urlopen
from urllib.error import HTTPError
from bs4 import BeautifulSoup
import re

def crawl_teams(url):
    try:
        html = urlopen(url=url)
    except HTTPError as e:
        return e

    try:
        bs = BeautifulSoup(html, 'html.parser')
        c_teams = bs.find('div', {'id' : 'bodyContent'}).find('span', {'id' : 'セントラル・リーグ'}).parent.next_sibling.next_sibling.find_all('a')
        p_teams = bs.find('div', {'id' : 'bodyContent'}).find('span', {'id' : 'パシフィック・リーグ'}).parent.next_sibling.next_sibling.find_all('a')
    except AttributeError as e:
        return e

    total_teams = c_teams + p_teams
    return total_teams


# def crawl_plyers(url):
#     try:
#         html = urlopen(url=url)
#     except HTTPError as e:
#         return e

#     try:
#         bs = BeautifulSoup(html, 'html.parser')
#         c_teams = bs.find('div', {'id' : 'bodyContent'}).find('span', {'id' : '投手'}).parent.next_sibling.next_sibling.find_all('a')
#     except AttributeError as e:
#         return e

#     total_teams = c_teams + p_teams
#     return total_teams

# teams = crawl_teams(url='https://ja.wikipedia.org/wiki/%E6%97%A5%E6%9C%AC%E3%81%AE%E3%83%97%E3%83%AD%E9%87%8E%E7%90%83%E9%81%B8%E6%89%8B%E4%B8%80%E8%A6%A7')
# print(teams)