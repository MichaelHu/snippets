\u@$(ifconfig | grep inet | grep -v inet6 | grep -v "inet 127.0" | grep -v "\-\->" | awk "{print \$2}") \W$ 
