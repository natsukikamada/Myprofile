class Ship {
public float x;
public float y;
public float velocity;
public float size;
}
class Bullet {
public float x;
public float y;
public float velocity;
}
class Wall {
public float x;
public float y;
public float velocity;
public float size;
}

Ship player;
Ship enemy;
Wall[] walls;
ArrayList<Bullet> bullets = new ArrayList();
PImage[] playerImages;
PImage[] enemyImages1;
PImage[] enemyImages2;
PImage[] enemyImages3;
PImage[] enemyImages4;
PImage[] enemyImages5;
//PImage[] enemyImages6;
int count = 0;


void setup() {
size(1000, 700);
player=new Ship();
player.x=50;
player.y=200;
enemy = new Ship();
enemy.x=600;
enemy.y=300;
enemy.velocity =random(7) + 8;
playerImages = new PImage[]{
  loadImage("kyabetu01.png"), loadImage("kyabetu02.png")
};
enemyImages1 = new PImage[]{
  loadImage("melon01.png"), loadImage("melon02.png"),};
  enemyImages2 = new PImage[]{
  loadImage("potato01.png"),loadImage("potato02.png"),};
  enemyImages3 = new PImage[]{
  loadImage("broccoli01.png"),loadImage("broccoli02.png"),};
  enemyImages4 = new PImage[]{
  loadImage("orange01.png"),loadImage("orange02.png"),};
  enemyImages5 = new PImage[]{
  loadImage("tomato01.png"),loadImage("tomato02.png"),};
  //enemyImages6 = new PImage[]{
 // loadImage("watermelon01.png"),loadImage("watermelon02.png"),}; 
walls=new Wall[3];
for (int i=0; i<3; i++) {
  Wall w=new Wall();
  w.x=i*100+300;
  w.y=0;
  w.velocity=random(5)+3;
  w.size=random(height-500, height-700);
  walls[i]=w;
}
}
boolean isHit(float px, float py, float pw, float ph,
float ex, float ey, float ew, float eh) {
float centerPx = px + pw / 2;
float centerPy = py + ph / 2;
float centerEx = ex + ew / 2;
float centerEy = ey + eh / 2;
if (abs(centerPx- centerEx) < pw / 2 + ew / 2) {
  if (abs(centerPy - centerEy) < ph / 2 + eh / 2) {
    return true;
  }
}
return false;
}


void draw() {
background(0);
count += 1;                                                                // atarihantei
enemy.y += enemy.velocity;

if (enemy.y < 0 || enemy.y+enemy.size>height-120) {
  enemy.velocity *= -1;
}
if (player.y<0|| player.y+player.size>height-180) {
  player.velocity *=-1;
}
player.y += player.velocity;
image(playerImages[count / 10 % 2],player.x,player.y,100,100);
image(enemyImages1[count / 10 % 2],enemy.x,enemy.y,100,100);
image(enemyImages2[count / 10 % 2],enemy.x +50,enemy.y + 150,100,100);
image(enemyImages3[count / 10 % 2],enemy.x+120,enemy.y +50,100,100);
image(enemyImages4[count / 10 % 2],enemy.x +170,enemy.y + 260,100,100);
image(enemyImages5[count / 10 % 2],enemy.x +230,enemy.y  +400,100,100);
//image(enemyImages6[count / 10 % 2],enemy.x +260,enemy.y +350,100,100);
int bulletCount = bullets.size();
for (int i = 0; i < bulletCount; i ++) {
  Bullet bullet = bullets.get(i);
  bullet.x += bullet.velocity;
  for (int j=0; j<walls.length; j++) {
    Wall w=walls[j];
    boolean isWallHit=isHit(w.x, w.y, 20, w.size, bullet.x, bullet.y, 10, 10);
    if (isWallHit) {
      bullet.velocity *=-1;
    }
  }
  boolean isHit = isHit(enemy.x, enemy.y, 50, 50, bullet.x, bullet.y, 10, 10);
  fill(255);
  if (isHit) {
  }
  ellipse(bullet.x, bullet.y, 10, 10);
}
for (int i=0; i<walls.length; i++) {
  Wall w=walls[i];
  w.y+=w.velocity;
  if (w.y<0||w.y+w.size>height) {
    w.velocity *=-1;
  }

  fill(255);
  rect(w.x, w.y, 20, w.size);
}
int timeLimit = 30;                        // timer
int countDown;
int ms = millis()/1000;
println(ms);
fill(0);
countDown = timeLimit - ms;
if (countDown > 0) {
  fill(255);
  textSize(20);
  text("COUNT DOWN", 825, 25);
  textSize(25);
  text(countDown, 880, 60);
} else {
  textSize(100);
  fill(0);
  rect(0, 0, 1000, 700);
  fill(255);
  text("TIME OVER", 230, 430);
  //  gamemode=02;
}
}



void shot() {
Bullet bullet = new Bullet();
bullet.x = player.x + 50;
bullet.y = player.y + 50;
bullet.velocity = 20;
bullets.add(bullet);
}
void keyPressed() {
if (keyCode==UP) {
  player.velocity = -5;
}
if (keyCode==DOWN) {
  player.velocity = +5;
}

if (key == ' ') {
  shot();
}
}
