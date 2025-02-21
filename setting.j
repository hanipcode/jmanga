#########################SETTTING#################################
#                                                                #
# This file is the setting file for jManga                       #
# no space allowed.. see the example bellow                      #
# if you want to edit base folder. just use BASE_FOLDER=YOURPATH #
#                                                                #
##################################################################

#specify the jManga setting page that contain function variable and setting
#lef this at default if you are'nt sure
JMANGA_FOLDER=~/.jManga

# Support socks proxy using tsocks. you should install tsocks on your system
# the option is just YES or NO (using capital)
# just type sudo apt-get install tsocks
USE_TSOCKS=NO

#Use proxy server. this is using our web proxy.
#the link will automatically converted to http://jManga-proxy.appspot.com/mangalink
USE_PROXY=NO

#number of retry set 0 if you don't want to retry failed download default is 15
NUMBER_OF_RETRY=15

#Wait time (if download failed) default is 2
RETRY_WAIT_TIME=2

# specify the bash folder. this is usallly the place of your manga folder
BASE_FOLDER=
