--deklaracija na globalni promenlivi

brojac=nil --dokolku se selektirani 2 sliki, da gi prikazuva vo rok od 1 sekunda pred da odluci dali se identicni ili ne

obidi=nil --broj na obidi vo koi igracot ke ja odigra igrata

vreme=nil --go zacuvuva vremeto na pocetok na nova igra

pominato_vreme=nil --go zacuvuva pominatoto vreme od pocetokot pa do zavrsuvanjeto na igrata

function love.load(arg) --ovde se dodeluvat pocetni vrednosti na promenlivi

math.randomseed( os.time() ) --za shuffle na nizata

start=0 --0 za da prikazuva meni na pocetok, 1 za new game, 2 za help, 3 za credits

brojac=0
vreme=0
obidi=0
pominato_vreme=0

pocetok=16 --na pocetok moze da se klikne na 16 sliki
selected=0 --na pocetok ima selektirano 0 sliki
select1=0 --prva selektirana slika
select2=0 --vtora selektirana slika

  clickable={true,true,true,true, --moznost da se klikne nad slikite
             true,true,true,true,
             true,true,true,true,
             true,true,true,true}
  crtanje={9,9,9,9, --na pocetok crta sini ramki
           9,9,9,9,
           9,9,9,9,
           9,9,9,9}
  koordinati={ {50, 50} , {200, 50} , {350, 50} , {500, 50} , --za smestuvanje na slikite
               {50, 175}, {200, 175}, {350, 175}, {500, 175},
               {50, 300}, {200, 300}, {350, 300}, {500, 300},
               {50, 425}, {200, 425}, {350, 425}, {500, 425}}

  sostojba={1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8} --pocetna sostojba na slikite

-- pravi shuffle na slikite - https://en.wikipedia.org/wiki/Fisher-Yates_shuffle
  for i = 16, 2, -1 do
  j = math.random(1, i)
  sostojba[i], sostojba[j] = sostojba[j], sostojba[i]
  end

  love.graphics.setBackgroundColor(255,255,255) --boja na pozadina

end --na funkcijata load

function love.mousepressed(x, y, button, istouch) --ovde se setiraat akciite sto ke se izvrsat so upotreba na gluvce
if start==1 then --dokolku e New Game
if pocetok>0 then --dokolku igracot igra
  if selected==0 then --dokolku nema selektirano slika
   if button == 1 then --dokolku e kliknat lev klik
--------------------------------------------------------------------------------pocnuva proverka za prva selektirana slika
for i=1,16 do --gi proveruva site sliki dali e kliknato nad niv i dali moze da bidat selektirani
  if x>=koordinati[i][1] and x<=koordinati[i][1]+100 and y>=koordinati[i][2] and y<=koordinati[i][2]+75 and selected==0 and clickable[i]==true
  then
    crtanje[i]=sostojba[i] --da ja prikaze slikata
    clickable[i]=false --da ne moze vtor pat da klikne na nea
    select1=i --da ja oznace kako prva selektirana
    selected=selected+1 --da pokaze deka ima 1 slika selektirana
  end --na if uslov
end --na for ciklus
--------------------------------------------------------------------------------
end --na kliknat lev klik
elseif selected==1 then --dokolku ima selektirano samo 1 slika
  if button == 1 then --dokolku e kliknat lev klik
--------------------------------------------------------------------------------pocnuva proverka za vtora selektirana slika
for i=1,16 do --gi proveruva site sliki dali e kliknato nad niv i dali moze da bidat selektirani
  if x>=koordinati[i][1] and x<=koordinati[i][1]+100 and y>=koordinati[i][2] and y<=koordinati[i][2]+75 and selected==1 and clickable[i]==true
    then
      crtanje[i]=sostojba[i] --da ja prikaze slikata
      clickable[i]=false --da ne moze vtor pat da klikne na nea
      select2=i --da ja oznace kako vtora selektirana
      selected=selected+1 --da pokaze deka ima 2 sliki selektirani
      brojac=love.timer.getTime() --se zema vremeto za da moze 1 sekunda da gi drze prikazani dvete otvoreni sliki
    end --na if uslov
  end --na for ciklus
--------------------------------------------------------------------------------
end --na proverka za lev klik
end --na selektiranje na prva ili vtora slika
--------------------------------------------------------------------------------
else --dokolku igrata e zavrsena, da se vrati vo menito
  if button==1 and x>=225 and x<=425 and y>=450 and y<=500 then --dokolku e kliknato na RETURN
    love.load() --da go prikaze menito
  end --na uslov za reload
 end --na proverka za pocetok
 end --na New Game

 if start==0 and button==1 and x>=225 and x<=425 and y>=230 and y<=280 then --se otvara New Game
   vreme=love.timer.getTime() --se zema vremeto na pocnuvanje na igrata
   start=1 --oznacuva deka momentalno se prikazuva nova igra
 end

 if start==0 and button==1 and x>=225 and x<=425 and y>=310 and y<=360 then --se otvara How to play
   start=2 --oznacuva deka momentalno se prikazuva upatstvo za igranje
 end

 if start==0 and button==1 and x>=225 and x<=425 and y>=390 and y<=440 then --se otvara Credits
   start=3 --oznacuva deka momentalno se prikazuvat informacii za igrata
 end

if start==0 and button==1 and x>=225 and x<=425 and y>=470 and y<=520 then --izlez od igrata
  love.event.push('quit') --da se iskluci igrata
end

if start==2 and button==1 and x>=225 and x<=425 and y>=450 and y<=500 then --od How to play da se vrati na pocetok
  love.load() --se vrakja vo menito
end

if start==3 and button==1 and x>=225 and x<=425 and y>=450 and y<=500 then --od Credits da se vrati na pocetok
  love.load() --se vrakja vo menito
end

end --na funkcija mousepressed

function love.draw(dt) --ovde se iscrtuva na ekranot

if start==0 then --poceten izgled na igrata posle nejzinoto vklucuvanje se prikazuva meni so opcii
  love.graphics.draw(love.graphics.newImage('assets/logo.jpg'),50,30)
  love.graphics.draw(love.graphics.newImage('assets/new_game.jpg'),225,230)
  love.graphics.draw(love.graphics.newImage('assets/how_to_play.jpg'),225,310)
  love.graphics.draw(love.graphics.newImage('assets/credits.jpg'),225,390)
  love.graphics.draw(love.graphics.newImage('assets/quit.jpg'),225,470)
end

if start==1 then --dokolku e otvorena nova igra
if pocetok>0 then --dokolku igracot seuste igra
  for i=1,16 do --crtaj gi site sliki
    love.graphics.draw(love.graphics.newImage('assets/'..tostring(crtanje[i])..'.jpg'),koordinati[i][1],koordinati[i][2])
  end --na for ciklus

  if selected==2 then --dokolku se izbereni 2 sliki, da gi prikazuva otvoreni
    if brojac-love.timer.getTime()>-1 then --gi prikazuva dvete otvoreni sliki 1 sekunda
      love.graphics.draw(love.graphics.newImage('assets/'..tostring(sostojba[select2])..'.jpg'),koordinati[select2][1],koordinati[select2][2])
    else
      if sostojba[select1]==sostojba[select2] then --dokolku dvete otvoreni sliki se isti
        crtanje[select1]=0 --da ne ja crta prvata otvorena
        crtanje[select2]=0 --da ne ja crta vtorata otvorena
        selected=0 --brojot na selektirani sliki e 0
        pocetok=pocetok-2 --otvoreni se 2 sliki
        obidi=obidi+1 --napraven e eden obid
      else --dokolku se razlicni dvete sliki
        crtanje[select1]=9 --da nacrta ramka nad prvata slika
        crtanje[select2]=9 --da nacrta ramka nad vtorata slika
        clickable[select1]=true --da ovozmozi klikanje vrz prvata slika
        clickable[select2]=true ----da ovozmozi klikanje vrz vtorata slika
        selected=0 --brojot na selektirani sliki e 0
        obidi=obidi+1 --napraven e eden obid
      end --na dali slikite se isti ili ne
    end --na if za brojac
  end --dokolku se selektirani 2 sliki
  pominato_vreme=love.timer.getTime()-vreme --vremeto od pocnuvanje na nova igra pa se dodeka igracot igra

else --dokolku e zavrsena igrata
  love.graphics.draw(love.graphics.newImage('assets/game_over.jpg'),50,50) --prikazi slika za zavrsena igra
  love.graphics.draw(love.graphics.newImage('assets/return.jpg'),225,450) --prikazi kopce za vrakjanje vo meni
  love.graphics.printf(tostring(math.floor(pominato_vreme)).." seconds", 0, 270, 650, "center") --prikazi go izminatoto vreme
  love.graphics.printf(tostring(obidi).." steps", 0, 350, 650, "center") --prikazi broj na obidi
end --na pocetok
end --na start==1

if start==2 then --dokolku e otvoreno pomos
  love.graphics.draw(love.graphics.newImage('assets/help.jpg'),50,50) --prikazi slika so pomos
  love.graphics.draw(love.graphics.newImage('assets/return.jpg'),225,450) --prikazi kopce za vrakjanje vo meni
end

if start==3 then --dokolku e otvoreno credits
  love.graphics.draw(love.graphics.newImage('assets/info.jpg'),50,50) --prikazi slika so informacii
  love.graphics.draw(love.graphics.newImage('assets/return.jpg'),225,450) --prikazi kopce za vrakjanje vo meni
end

collectgarbage("collect") --da ja isprazni memorijata

end --na funkcija draw
