import requests
from bs4 import BeautifulSoup
import socks
import socket
from urllib.request import urlopen
import re
import json
import urllib.request
from firebase import firebase
import time



class Player:


    def __init__(self, jersey_number, name, bats, throws, height, weight, origin, salary):
        self.jersey_number = jersey_number
        self.name = name
        self.bats = bats
        self.throws = throws
        self.height = height
        self.weight = weight
        self.origin = origin
        self.salary = salary
        
        
        



session = requests.Session()
headers = {"User-Agent":"Mozilla/5.0 (iPhone; CPU iPhone OS 7_1_2 like Mac OS X) AppleWebKit/537.51.2 (KHTML, like Gecko) Version/7.0 Mobile/11D257 Safari/9537.53"}
firebase = firebase.FirebaseApplication('https://fir-assignment-9f9e6.firebaseio.com', None)



socks.set_default_proxy(socks.SOCKS5, "localhost", 9150)
socket.socket = socks.socksocket

def getURLs():
    team_names = []
    team_links = []
    url = "http://www.espn.com/mlb/players"
    req = session.get(url, headers=headers)
    soup = BeautifulSoup(req.text, "lxml")
    table = soup.find("div", {"id" : "my-players-table"})
    links = table.find_all('a')
    for link in links:
        team_names.append(link.get_text())
        hyperlink = link.attrs["href"]
        team_links.append(hyperlink)
    real_team_links = team_links[1::2] 
    
    getPlayers(real_team_links,team_names)

        
    

def getPlayers(hyperlinks,team_names):
    
    for i in range(0,len(team_names)):
        team_name = team_names[i]
        print(team_name)
        url = "http://www.espn.com" + hyperlinks[i]
        req = session.get(url, headers=headers)
        bsObj = BeautifulSoup(req.text, "lxml")
        jersey_number = ""
        name = ""
        bats = ""
        throws = ""
        height = ""
        weight = ""
        origin = ""
        salary = ""
        all_players = []
        players_tables = bsObj.find_all("table", {"class" : "tablehead"})
        for table in players_tables:
            players = table.find_all("tr", {"class" : re.compile("(even|odd)row\splayer-[0-9]*")})
            for player in players:
                numbers = player.find_all("td")
                for i in range(0, len(numbers)):
                    number = numbers[i].get_text()
                    if i == 0:
                        jersey_number = number
                    elif i == 1:
                        name = number
                    elif i == 2:
                        bats = number
                    elif i == 3:
                        throws = number
                    elif i == 4:
                        height = number
                    elif i == 5:
                        weight = number
                    elif i == 6:
                        origin = number
                    else:
                        salary = number
                p = Player(jersey_number,name,bats,throws,height,weight,origin,salary)
                all_players.append(p)
        postPlayers(team_name,all_players)
        time.sleep(30)
                

def postPlayers(forTeamName,players):
     path = "/teams/{}/players".format(forTeamName)
     print("path is",path)
     for player in players:
         new_user = {'jersey_number':player.jersey_number, 'name':player.name, 'bats':player.bats, 'throws':player.throws,'height':player.height,'weight':player.weight,
                        'origin':player.origin
                        }
         if len(path) > 20:
             try:
                 result = firebase.post(path, new_user)
             except:
                 print("error")
             
    

       
getURLs() 