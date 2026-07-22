# 2025-11-17 18:04:12 by RouterOS 7.12.1
# software id = SXCR-I1C1
#
# model = RB5009UG+S+
# serial number = HF6090YDWEG
/ip firewall mangle
add action=mark-connection chain=forward disabled=yes dst-port=53 \
    new-connection-mark=dns-priority passthrough=yes protocol=udp
add action=mark-packet chain=forward connection-mark=dns-priority disabled=\
    yes new-packet-mark=dns-packet passthrough=no
add action=mark-packet chain=prerouting disabled=yes new-packet-mark=ICMP \
    passthrough=no protocol=icmp
add action=mark-packet chain=postrouting disabled=yes new-packet-mark=ICMP \
    passthrough=no protocol=icmp
add action=mark-routing chain=prerouting comment=SPeedteset dst-address-list=\
    speedtest dst-port=80,443 new-routing-mark=speedtest passthrough=no \
    protocol=tcp src-address-list=private-lokal
add action=mark-connection chain=prerouting comment=Belok-Conn \
    dst-address-list=Belok new-connection-mark=Belok-conn passthrough=yes \
    src-address-list=lokal time=17h-22h30m,mon,tue,wed,thu,fri
add action=mark-routing chain=prerouting comment=Belok-Routing \
    connection-mark=Belok-conn new-routing-mark=Belok passthrough=no \
    src-address-list=lokal time=17h-22h30m,mon,tue,wed,thu,fri
# inactive time
add action=mark-connection chain=prerouting comment=Belok-Conn \
    dst-address-list=Belok new-connection-mark=Belok-conn passthrough=yes \
    src-address-list=lokal time=7h-23h,sun,sat
# inactive time
add action=mark-routing chain=prerouting comment=Belok-Routing \
    connection-mark=Belok-conn new-routing-mark=Belok passthrough=no \
    src-address-list=lokal time=7h-23h,sun,sat
add action=mark-connection chain=prerouting comment=Belok-Conn \
    dst-address-list=GAME-RAW new-connection-mark=Game-Raw passthrough=yes \
    src-address-list=lokal
add action=mark-routing chain=prerouting comment=Belok-Routing \
    connection-mark=Game-Raw new-routing-mark=GAME-RAW passthrough=no \
    src-address-list=lokal
add action=mark-connection chain=prerouting comment=Belok-Conn disabled=yes \
    dst-address-list=Tiktok new-connection-mark=Tiktok-RAW passthrough=yes \
    src-address-list=lokal
add action=mark-routing chain=prerouting comment=Belok-Routing \
    connection-mark=Tiktok-RAW disabled=yes new-routing-mark=Tiktok \
    passthrough=no src-address-list=lokal
add action=mark-connection chain=prerouting comment=ICMP disabled=yes \
    new-connection-mark=icmp-conn passthrough=yes protocol=icmp
add action=mark-packet chain=prerouting connection-mark=icmp-conn disabled=\
    yes new-packet-mark=icmp-packet passthrough=no
add action=mark-connection chain=prerouting comment="Common Traffic" \
    disabled=yes dst-port=\
    21,22,23,80,81,88,443,554,182,5060,8000-8081,843,8777 \
    new-connection-mark=common-conn passthrough=yes protocol=tcp
add action=mark-connection chain=prerouting disabled=yes new-connection-mark=\
    common-conn packet-size=251-9999 passthrough=yes protocol=tcp
add action=mark-connection chain=prerouting disabled=yes dst-port=\
    5060,1935,1194,1701,1723,500,4500,6881-6889 new-connection-mark=\
    common-conn passthrough=yes protocol=udp
add action=mark-connection chain=prerouting disabled=yes new-connection-mark=\
    common-conn packet-size=251-9999 passthrough=yes protocol=udp
add action=mark-packet chain=prerouting connection-mark=common-conn disabled=\
    yes new-packet-mark=common-packet passthrough=no
add action=mark-connection chain=prerouting comment="Small Traffic" disabled=\
    yes new-connection-mark=small-conn packet-size=0-250 passthrough=yes \
    protocol=!icmp
add action=mark-packet chain=prerouting connection-mark=small-conn disabled=\
    yes new-packet-mark=small-packet passthrough=no
add action=change-ttl chain=postrouting comment="Hotspot Protect" disabled=\
    yes dst-address-list=Voucher new-ttl=set:1 passthrough=no
add action=mark-connection chain=prerouting comment=Telegram-STB disabled=yes \
    dst-address-list=Telegram new-connection-mark=Tele-STB passthrough=yes \
    src-address=192.168.76.2/31
add action=mark-connection chain=prerouting comment="TOTAL ALL" disabled=yes \
    dst-address-list="!IP MENGGUNAKAN PORT RANDOM" new-connection-mark=\
    "TOTAL ALL" passthrough=yes protocol=!icmp src-address-list=lokal
add action=mark-packet chain=forward connection-mark="TOTAL ALL" disabled=yes \
    dst-address-list=lokal in-interface-list=WAN new-packet-mark=\
    "DOWNLOAD ALL" passthrough=yes protocol=!icmp src-address-list=\
    "!IP MENGGUNAKAN PORT RANDOM"
add action=mark-packet chain=forward connection-mark="TOTAL ALL" disabled=yes \
    dst-address-list="!IP MENGGUNAKAN PORT RANDOM" new-packet-mark=\
    "UPLOAD ALL" out-interface-list=WAN passthrough=yes protocol=!icmp \
    src-address-list=lokal
add action=add-dst-to-address-list address-list="IP MENGGUNAKAN PORT RANDOM" \
    address-list-timeout=1m chain=prerouting comment=GAME disabled=yes \
    dst-address-list=!kecuali dst-port=\
    !21,22,23,81,88,5060,843,182,8777,1935,53,8000-8081,443,80 protocol=tcp \
    src-address-list=lokal
add action=add-dst-to-address-list address-list="IP MENGGUNAKAN PORT RANDOM" \
    address-list-timeout=1m chain=prerouting disabled=yes dst-address-list=\
    !kecuali dst-port=\
    !21,22,23,81,88,5060,843,182,8777,1935,53,8000-8081,443,80 protocol=udp \
    src-address-list=lokal
add action=mark-packet chain=forward disabled=yes dst-address-list=lokal \
    in-interface-list=WAN new-packet-mark="PORT SELAIN PORT UMUM(GAME) DOWN" \
    passthrough=yes src-address-list="IP MENGGUNAKAN PORT RANDOM"
add action=mark-packet chain=forward disabled=yes dst-address-list=\
    "IP MENGGUNAKAN PORT RANDOM" new-packet-mark=\
    "PORT SELAIN PORT UMUM(GAME) UP" out-interface-list=WAN passthrough=yes \
    src-address-list=lokal
add action=mark-packet chain=forward comment=GAME-RAW disabled=yes \
    dst-address-list=lokal in-interface-list=WAN new-packet-mark=\
    "PORT SELAIN PORT UMUM(GAME) DOWN" passthrough=yes src-address-list=\
    GAME-RAW
add action=mark-packet chain=forward disabled=yes dst-address-list=GAME-RAW \
    new-packet-mark="PORT SELAIN PORT UMUM(GAME) UP" out-interface-list=WAN \
    passthrough=yes src-address-list=lokal
add action=mark-connection chain=prerouting connection-rate=0-999k disabled=\
    yes dst-address-list="IP MENGGUNAKAN PORT RANDOM" new-connection-mark=\
    Game passthrough=yes src-address-list=lokal
add action=add-dst-to-address-list address-list="PORT BERAT" \
    address-list-timeout=15m chain=prerouting comment="PORT RANDOM BERAT" \
    connection-rate=1M-999M disabled=yes dst-address-list=\
    "IP MENGGUNAKAN PORT RANDOM" src-address-list=lokal
add action=add-dst-to-address-list address-list="PORT BERAT" \
    address-list-timeout=15m chain=prerouting connection-bytes=\
    1000000-999000000 disabled=yes dst-address-list=\
    "IP MENGGUNAKAN PORT RANDOM" src-address-list=lokal
add action=mark-packet chain=forward disabled=yes dst-address-list=lokal \
    in-interface-list=WAN new-packet-mark="PORT BERAT DOWN" passthrough=no \
    src-address-list="PORT BERAT"
add action=mark-packet chain=forward disabled=yes dst-address-list=\
    "PORT BERAT" new-packet-mark="PORT BERAT UP" out-interface-list=WAN \
    passthrough=no src-address-list=lokal
add action=mark-connection chain=prerouting comment=ICMP disabled=yes \
    new-connection-mark=ICMP passthrough=yes protocol=icmp
add action=mark-packet chain=forward connection-mark=ICMP disabled=yes \
    in-interface-list=WAN new-packet-mark="ICMP DOWN" passthrough=no
add action=mark-packet chain=forward connection-mark=ICMP disabled=yes \
    new-packet-mark="ICMP UP" out-interface-list=WAN passthrough=no
add action=mark-connection chain=prerouting comment=SPEEDTEST disabled=yes \
    dst-address-list=speedtest new-connection-mark=speedtest passthrough=yes \
    src-address-list=lokal
add action=mark-packet chain=forward connection-mark=speedtest disabled=yes \
    in-interface-list=WAN new-packet-mark="SPEEDTEST DOWN" passthrough=no
add action=mark-packet chain=forward connection-mark=speedtest disabled=yes \
    new-packet-mark="SPEEDTEST UP" out-interface-list=WAN passthrough=no
add action=add-dst-to-address-list address-list="UMUM BERAT" \
    address-list-timeout=25s chain=prerouting comment="TRAFIC UMUM BERAT" \
    connection-bytes=5000000-999000000 connection-mark="TOTAL ALL" \
    connection-rate=512k-999M disabled=yes dst-address-list=\
    "!IP MENGGUNAKAN PORT RANDOM" src-address-list=lokal
add action=mark-connection chain=prerouting connection-bytes=\
    5000000-999000000 connection-mark="TOTAL ALL" connection-rate=512k-999M \
    disabled=yes dst-address-list=!Youtube new-connection-mark="UMUM BERAT" \
    passthrough=yes
add action=mark-packet chain=forward connection-mark="UMUM BERAT" disabled=\
    yes in-interface-list=WAN new-packet-mark="UMUM BERAT DOWN" passthrough=\
    no
add action=mark-packet chain=forward connection-mark="UMUM BERAT" disabled=\
    yes new-packet-mark="UMUM BERAT UP" out-interface-list=WAN passthrough=no
add action=mark-connection chain=prerouting comment="STREAMING VIDEO" \
    disabled=yes dst-address-list=Youtube new-connection-mark=YOUTUBE \
    passthrough=yes src-address-list=lokal
add action=mark-packet chain=forward connection-mark=YOUTUBE disabled=yes \
    in-interface-list=WAN new-packet-mark="STREAMING VIDEO DOWN" passthrough=\
    no
add action=mark-packet chain=forward connection-mark=YOUTUBE disabled=yes \
    new-packet-mark="STREAMING VIDEO UP" out-interface-list=WAN passthrough=\
    no
add action=mark-routing chain=prerouting comment=Youtube-Pisah \
    connection-mark=YOUTUBE disabled=yes dst-address-list=!kecuali \
    new-routing-mark=Belok passthrough=no src-address-list=lokal
add action=mark-routing chain=prerouting comment=Berat-Pisah connection-mark=\
    "UMUM BERAT" disabled=yes dst-address-list=!kecuali new-routing-mark=\
    Belok passthrough=no src-address-list=lokal
add action=mark-routing chain=prerouting comment=Speedtest-Pisah \
    connection-mark=speedtest disabled=yes dst-address-list=!kecuali \
    new-routing-mark=Belok passthrough=no src-address-list=lokal
add action=mark-connection chain=prerouting comment=";;;;;;;;;;;;;;;;;;;ICMP" \
    disabled=yes dst-address-list=!kecuali new-connection-mark=icmp-conn \
    passthrough=yes protocol=icmp src-address-list=lokal
add action=mark-packet chain=prerouting connection-mark=icmp-conn disabled=\
    yes new-packet-mark=icmp-packet passthrough=no
add action=mark-connection chain=prerouting comment=Google disabled=yes \
    dst-address=!8.8.0.0/16 dst-address-list=Google new-connection-mark=\
    Google passthrough=yes src-address-list=lokal
add action=mark-routing chain=prerouting comment=Google-Pisah \
    connection-mark=Google disabled=yes dst-address-list=!kecuali \
    new-routing-mark=Belok passthrough=yes src-address-list=lokal
add action=mark-connection chain=prerouting comment="Common Traffic" \
    disabled=yes dst-address-list=!kecuali dst-port=\
    21,22,23,80,81,88,443,554,182,5060,8000-8081,843,8777 \
    new-connection-mark=common-conn passthrough=yes protocol=tcp \
    src-address-list=lokal
add action=mark-connection chain=prerouting disabled=yes new-connection-mark=\
    common-conn packet-size=251-9999 passthrough=yes protocol=tcp
add action=mark-connection chain=prerouting disabled=yes dst-address-list=\
    !kecuali dst-port=5060,1935,1194,1701,1723,500,4500,6881-6889 \
    new-connection-mark=common-conn passthrough=yes protocol=udp \
    src-address-list=lokal
add action=mark-connection chain=prerouting disabled=yes new-connection-mark=\
    common-conn packet-size=251-9999 passthrough=yes protocol=udp
add action=mark-packet chain=prerouting connection-mark=common-conn disabled=\
    yes new-packet-mark=common-packet passthrough=no
add action=mark-connection chain=prerouting comment="Small Traffic" disabled=\
    yes new-connection-mark=small-conn packet-size=0-250 passthrough=yes \
    protocol=!icmp
add action=mark-packet chain=prerouting connection-mark=small-conn disabled=\
    yes new-packet-mark=small-packet passthrough=no
add action=jump chain=prerouting comment=\
    "[ RouterOS Script is proudly powered by BuanaNET SECURE ]" jump-target=\
    Buananet-Pre
add action=jump chain=postrouting jump-target=Buananet-Pos
add action=jump chain=input jump-target=Buananet-Inp
add action=jump chain=output jump-target=Buananet-Out
add action=mark-packet chain=Buananet-Pre comment=\
    "Ping (icmp) + Latency Mangle Rules - Buananet.com" new-packet-mark=\
    ping_mark packet-size=0-64 passthrough=no protocol=icmp
add action=mark-packet chain=Buananet-Pos new-packet-mark=ping_mark \
    packet-size=0-64 passthrough=no protocol=icmp
add action=mark-packet chain=Buananet-Pre comment=\
    "Dns (53) + Tracert Mangle Rules - Buananet.com" new-packet-mark=dns_mark \
    packet-size=0-512 passthrough=no port=\
    53,5353,33434-33534,30000,64872-64875 protocol=udp
add action=mark-packet chain=Buananet-Pos new-packet-mark=dns_mark \
    packet-size=0-512 passthrough=no port=\
    53,5353,33434-33534,30000,64872-64875 protocol=udp
add action=mark-packet chain=Buananet-Pre comment=\
    "Winbox & Network Tools Mangle Rules - Buananet.com" new-packet-mark=\
    winbox_mark passthrough=no port=\
    20-25,2112,3389,4495,5800,5900,5938,6568,7070,8291,8728,8729 protocol=tcp
add action=mark-packet chain=Buananet-Pos new-packet-mark=winbox_mark \
    passthrough=no port=\
    20-25,2112,3389,4495,5800,5900,5938,6568,7070,8291,8728,8729 protocol=tcp
add action=mark-packet chain=Buananet-Pre comment=\
    "Bypass Local Traffic Mangle Rules - Buananet.com" dst-address-list=lokal \
    new-packet-mark=local_bypass_mark passthrough=no src-address-list=lokal
add action=mark-packet chain=Buananet-Pos dst-address-list=lokal \
    new-packet-mark=local_bypass_mark passthrough=no src-address-list=lokal
add action=mark-packet chain=Buananet-Inp dst-address-list=lokal \
    new-packet-mark=local_bypass_mark passthrough=no src-address-list=lokal
add action=mark-packet chain=Buananet-Out dst-address-list=lokal \
    new-packet-mark=local_bypass_mark passthrough=no src-address-list=lokal
add action=mark-connection chain=Buananet-Pre comment=\
    "Online Games Connection Mark - Buananet.com" dst-address-list=\
    List-IP-Games new-connection-mark=conn-game-online passthrough=yes \
    src-address-list=lokal
add action=jump chain=Buananet-Pre jump-target=jump-game-1A port=\
    !0-1023,1080,1194,1337,1410-1480,1451-1471,1701-1723,1935,2088,2112 \
    protocol=tcp src-address-list=lokal
add action=jump chain=jump-game-1A jump-target=jump-game-2A port=\
    !2400-2565,2453-2471,2545-2565,3128,3389,3478-3479,3999,4244,4380,4495 \
    protocol=tcp src-address-list=lokal
add action=jump chain=jump-game-2A jump-target=jump-game-3A port=\
    !4500,4999,5060-5070,5200-5260,5200-5280,5349,5353,5800,5900,5938,6568 \
    protocol=tcp src-address-list=lokal
add action=jump chain=jump-game-3A jump-target=jump-game-4A port="!6667,7070,8\
    001,8080,8100,8200,8291,8444-8471,8578,8690,8728,8729,8801-8811" \
    protocol=tcp src-address-list=lokal
add action=mark-connection chain=jump-game-4A new-connection-mark=\
    conn-game-online port="!8888,9917,12673,19305-19309,30000,33434-33534,3478\
    4,45395,45620,50318,59234" protocol=tcp src-address-list=lokal
add action=jump chain=Buananet-Pre jump-target=jump-game-1B port=\
    !0-1023,1080,1194,1337,1410-1480,1451-1471,1701-1723,1935,2088,2112 \
    protocol=udp src-address-list=lokal
add action=jump chain=jump-game-1B jump-target=jump-game-2B port=\
    !2400-2565,2453-2471,2545-2565,3128,3389,3478-3479,3999,4244,4380,4495 \
    protocol=udp src-address-list=lokal
add action=jump chain=jump-game-2B jump-target=jump-game-3B port=\
    !4500,4999,5060-5070,5200-5260,5200-5280,5349,5353,5800,5900,5938,6568 \
    protocol=udp src-address-list=lokal
add action=jump chain=jump-game-3B jump-target=jump-game-4B port="!6667,7070,8\
    001,8080,8100,8200,8291,8444-8471,8578,8690,8728,8729,8801-8811" \
    protocol=udp src-address-list=lokal
add action=mark-connection chain=jump-game-4B new-connection-mark=\
    conn-game-online port="!8888,9917,12673,19305-19309,30000,33434-33534,3478\
    4,45395,45620,50318,59234" protocol=udp src-address-list=lokal
add action=mark-packet chain=Buananet-Pre connection-mark=conn-game-online \
    connection-rate=0-1M new-packet-mark=game_mark packet-size=0-512 \
    passthrough=no src-address-list=lokal
add action=mark-packet chain=Buananet-Pos connection-mark=conn-game-online \
    connection-rate=0-1M dst-address-list=lokal new-packet-mark=game_mark \
    packet-size=0-1024 passthrough=no
add action=mark-connection chain=Buananet-Pre comment=\
    "Speedtest Connection Mark - Buananet.com" dst-address-list=Speedtest \
    new-connection-mark=speedtest_conn passthrough=yes src-address-list=lokal
add action=mark-packet chain=Buananet-Pre connection-mark=speedtest_conn \
    new-packet-mark=speedtest_mark passthrough=no src-address-list=lokal
add action=mark-packet chain=Buananet-Pos connection-mark=speedtest_conn \
    dst-address-list=lokal new-packet-mark=speedtest_mark passthrough=no
add action=mark-connection chain=Buananet-Pre comment=\
    "E-Commerce - Buananet.com" dst-address-list=E-Commerce \
    new-connection-mark=E-Commerce-Conn passthrough=yes src-address-list=\
    lokal
add action=mark-packet chain=Buananet-Pre connection-mark=E-Commerce-Conn \
    new-packet-mark=e_commerce_mark_up passthrough=no src-address-list=lokal
add action=mark-packet chain=Buananet-Pos connection-mark=E-Commerce-Conn \
    dst-address-list=lokal new-packet-mark=e_commerce_mark_down passthrough=\
    no
add action=mark-connection chain=Buananet-Pre comment=\
    "Social Media - Buananet.com" dst-address-list=Social-Media \
    new-connection-mark=Social-Media-Conn passthrough=yes src-address-list=\
    lokal
add action=mark-packet chain=Buananet-Pre connection-mark=Social-Media-Conn \
    new-packet-mark=social_media_mark_up passthrough=no src-address-list=\
    lokal
add action=mark-packet chain=Buananet-Pos connection-mark=Social-Media-Conn \
    dst-address-list=lokal new-packet-mark=social_media_mark_down \
    passthrough=no
add action=mark-connection chain=Buananet-Pre comment=\
    "Streaming Video - Buananet.com" dst-address-list=Streaming-Video \
    new-connection-mark=Streaming-Video-Conn passthrough=yes \
    src-address-list=lokal
add action=mark-packet chain=Buananet-Pre connection-mark=\
    Streaming-Video-Conn new-packet-mark=streaming_video_mark_up passthrough=\
    no src-address-list=lokal
add action=mark-packet chain=Buananet-Pos connection-mark=\
    Streaming-Video-Conn dst-address-list=lokal new-packet-mark=\
    streaming_video_mark_down passthrough=no
add action=mark-connection chain=Buananet-Pre comment=\
    "Video Conference - Buananet.com" dst-address-list=Video-Conference \
    new-connection-mark=Video-Conference-Conn passthrough=yes \
    src-address-list=lokal
add action=mark-packet chain=Buananet-Pre connection-mark=\
    Video-Conference-Conn new-packet-mark=video_conference_mark_up \
    passthrough=no src-address-list=lokal
add action=mark-packet chain=Buananet-Pos connection-mark=\
    Video-Conference-Conn dst-address-list=lokal new-packet-mark=\
    video_conference_mark_down passthrough=no
add action=mark-packet chain=Buananet-Pre comment=\
    "Fastest Priority Packet Mark UP - Buananet.com" connection-rate=0-1M \
    new-packet-mark=fastest_mark_up packet-size=0-1024 passthrough=no \
    src-address-list=lokal
add action=mark-packet chain=Buananet-Pos connection-rate=0-1M \
    dst-address-list=lokal new-packet-mark=fastest_mark_down packet-size=\
    0-1024 passthrough=no
add action=mark-packet chain=Buananet-Pre comment=\
    "Heavy Traffic Packet Mark UP - Buananet.com" new-packet-mark=\
    heavy_traffic_mark_up passthrough=no src-address-list=lokal
add action=mark-packet chain=Buananet-Pos dst-address-list=lokal \
    new-packet-mark=heavy_traffic_mark_down passthrough=no
add action=return chain=Buananet-Pre
add action=return chain=Buananet-Pos
add action=return chain=Buananet-Inp
add action=return chain=Buananet-Out
