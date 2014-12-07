/*
 Hello world!
*/

#include "eth_util.angelscript"

string entry;
string info;
string ENDGAME = "Game Over. Press Enter to Restart.";

bool awake = false;
bool up = false;
bool dressed = false;
bool door = false;
bool flipped = false;
bool outside = false;
bool end = false;
bool action = false;
bool sleep = false;

int timeLeft = 60000;
int delay = 0;
int id;
int menuInt = 1;

array<int> checks = {0,0,0,0,0,0,0,0,0,0};

void main()
{
	LoadScene("empty", "menu", "menuRun");

	// Prefer setting window properties in the app.enml file
	// SetWindowProperties("Ethanon Engine", 1024, 768, true, true, PF32BIT);
}

void ach(){
	for(int i = 0; i < checks.length(); i++){
		if(i < 5) id = AddEntity("ach.ent",vector3(100, ((i) * 115) + 20,0));
		else if(i > 4)id = AddEntity("ach.ent",vector3(450, ((i - 5) * 115) + 20, 0));
		if(checks[i] == 1)SeekEntity(id).SetSprite("ach" + i + ".png");
		}
	}

void back(){
	ETHInput@ input = GetInputHandle();
	if(input.GetKeyState(K_ENTER) == KS_HIT)LoadScene("empty", "menu", "menuRun");;
	}

void menu(){
	id = AddEntity("menu.ent",vector3(400,300,0));
	menuInt = 1;
	}

void menuRun(){
	ETHInput@ input = GetInputHandle();
	if(input.GetKeyState(K_UP) == KS_HIT){
		if(menuInt <= 1)menuInt = 3;
		else{menuInt--;}
		SeekEntity(id).SetSprite("menu" + menuInt + ".png");
		}
	if(input.GetKeyState(K_DOWN) == KS_HIT){
		if(menuInt >= 3)menuInt = 1;
		else{menuInt++;}
		SeekEntity(id).SetSprite("menu" + menuInt + ".png");
		}
	if(input.GetKeyState(K_ENTER) == KS_HIT){
		if(menuInt == 1){
			LoadScene("empty", "Start", "Run");
			}
		if(menuInt == 2){
			LoadScene("empty", "ach", "back");
			}
		if(menuInt == 3){
			Exit();
			}
		}
	}

void Start(){
	id = AddEntity("background.ent",vector3(400,300,0));
	delay = GetTime();
	}
	
void Run(){
	ETHInput@ input = GetInputHandle();
	if(!end)timeLeft = 60000 + delay - GetTime();
	if(timeLeft >= 10)DrawText(vector2(0,300),"00:" + floor(timeLeft / 1000), "Verdana14_shadow.fnt", ARGB(250,255,255,255));
	else if(timeLeft < 10 and timeLeft >= 0)DrawText(vector2(0,300),"00:0" + floor(timeLeft / 1000), "Verdana14_shadow.fnt", ARGB(250,255,255,255));
	if(timeLeft < 0){
		DrawText(vector2(0,300),"00:00", "Verdana14_shadow.fnt", ARGB(250,255,255,255));
		end = true;
		}
	DrawText(vector2(0,560),info, "Verdana14_shadow.fnt", ARGB(250,255,255,255));
	DrawText(vector2(0,580),">" + entry, "Verdana14_shadow.fnt", ARGB(250,255,255,255));
	if(end){
		endgame();
		if(input.GetKeyState(K_ENTER) == KS_HIT){
		checkAchieve();
		awake = false;
		up = false;
		dressed = false;
		door = false;
		flipped = false;
		outside = false;
		end = false;
		action = false;
		sleep = false;
		info = "";
		LoadScene("empty", "ach", "back");
			}
		}
	else{parseKey();}
	}
	
void checkAchieve(){
	if(!action)checks[0] = 1;
	if(flipped)checks[1] = 1;
	if(flipped and dressed and door)checks[2] = 1;
	if(outside and !dressed and door)checks[3] = 1;
	if(outside and dressed and door)checks[4] = 1;
	if(timeLeft >= 30000 and !sleep)checks[5] = 1;
	if(timeLeft <= 10000 and timeLeft > 0)checks[6] = 1;
	if(outside and !door)checks[7] = 1;
	if(up and dressed and sleep and door)checks[8] = 1;
	if(sleep and !up)checks[9] = 1;
	}

void endgame(){
	ETHInput@ input = GetInputHandle();
	if(flipped)info = "You did a headstand. You're still late for class. " + ENDGAME;
	if(!awake){
		info = "You overslept. Good Job. " + ENDGAME;
		}
	if(sleep and up){
		info = "You got up and fell asleep. Good Job. " + ENDGAME;
		}
	if(sleep and !up){
		info = "You didn't even try. " + ENDGAME;
		}
	else if(!up){
		info = "You couldn't get out of bed. Good Job. " + ENDGAME;
		}
	else if(outside){
		if(dressed and door)info = "You got to class. Yay! " + ENDGAME;
		if(dressed and !door)info = "You forgot to open the door. Good Job. " + ENDGAME;
		if(!dressed and door)info = "You walked outside naked. Put on some clothes next time pervert. " + ENDGAME;
		if(!dressed and !door)info = "You didn't open the door idiot. " + ENDGAME;
		}
}
	
void parseKey(){
	ETHInput@ input = GetInputHandle();
	if(input.GetKeyState(K_A) == KS_HIT) entry += "a";
	if(input.GetKeyState(K_B) == KS_HIT) entry += "b";
	if(input.GetKeyState(K_C) == KS_HIT) entry += "c";
	if(input.GetKeyState(K_D) == KS_HIT) entry += "d";
	if(input.GetKeyState(K_E) == KS_HIT) entry += "e";
	if(input.GetKeyState(K_F) == KS_HIT) entry += "f";
	if(input.GetKeyState(K_G) == KS_HIT) entry += "g";
	if(input.GetKeyState(K_H) == KS_HIT) entry += "h";
	if(input.GetKeyState(K_I) == KS_HIT) entry += "i";
	if(input.GetKeyState(K_J) == KS_HIT) entry += "j";
	if(input.GetKeyState(K_K) == KS_HIT) entry += "k";
	if(input.GetKeyState(K_L) == KS_HIT) entry += "l";
	if(input.GetKeyState(K_M) == KS_HIT) entry += "m";
	if(input.GetKeyState(K_N) == KS_HIT) entry += "n";
	if(input.GetKeyState(K_O) == KS_HIT) entry += "o";
	if(input.GetKeyState(K_P) == KS_HIT) entry += "p";
	if(input.GetKeyState(K_Q) == KS_HIT) entry += "q";
	if(input.GetKeyState(K_R) == KS_HIT) entry += "r";
	if(input.GetKeyState(K_S) == KS_HIT) entry += "s";
	if(input.GetKeyState(K_T) == KS_HIT) entry += "t";
	if(input.GetKeyState(K_U) == KS_HIT) entry += "u";
	if(input.GetKeyState(K_V) == KS_HIT) entry += "v";
	if(input.GetKeyState(K_W) == KS_HIT) entry += "w";
	if(input.GetKeyState(K_X) == KS_HIT) entry += "x";
	if(input.GetKeyState(K_Y) == KS_HIT) entry += "y";
	if(input.GetKeyState(K_Z) == KS_HIT) entry += "z";
	if(input.GetKeyState(K_SPACE) == KS_HIT) entry += " ";
	if(input.GetKeyState(K_BACKSPACE) == KS_HIT or input.GetKeyState(K_DELETE) == KS_HIT){
		string temp = entry.substr(0, entry.length() - 1);
		entry = temp;
		}
	if(input.GetKeyState(K_ENTER) == KS_HIT){
		performAction(entry);
		entry = "";
		}
	}
	
void performAction(string command){
	action = true;
	if(command == "wake up"){
		if(not awake){
			awake = true;
			info = "You woke up.";
			}
		else{
			info = "You're already awake.";
			}
		}
	else if(command == "get up"){
		if(up)info = "You're already up.";
		else if(awake){
			SeekEntity(id).SetSprite("outofbed.png");
			info = "You got out of bed.";
			up = true;
			}
		else{
			info = "You're still asleep.";
			}
		}
	else if(command == "do a headstand" or command == "headstand"){
		if(up and dressed and door)SeekEntity(id).SetSprite("clothesheadstand.png");
		else if(up and dressed)SeekEntity(id).SetSprite("clothesheadstandclosed.png");
		else if(up and door)SeekEntity(id).SetSprite("nakedheadstand.png");
		else if(up)SeekEntity(id).SetSprite("headstand.png");
		if(up){
			flipped = true;
			end = true;
			}
		else{
			info = "You can't do that in bed";
			}
		}
	else if(command == "door" or command == "open door"){
		if(up and !door){
			door = true;
			info = "You opened the door";
			if(dressed)SeekEntity(id).SetSprite("clothesopendoor.png");
			else if(!dressed)SeekEntity(id).SetSprite("nakedopendoor.png");
			}
		else if(up and door){
			info = "The door is already open.";
			}
		else if(!up){
			info = "You can't do that in bed.";
			}
		}
	else if(command == "get dressed"){
		if(up and !dressed){
			dressed = true;
			info = "You put on some clothes.";
			if(door)SeekEntity(id).SetSprite("clothesopendoor.png");
			else if(!door)SeekEntity(id).SetSprite("clothes.png");
			}
		else if(up and dressed){
			info = "You are already dressed.";
			}
		else if(!up){
			info = "You can't do that in bed.";
			}
		}
	else if(command == "go outside" or command == "go to class" or command == "walk to class" or command == "walk outside"){
		if(!up){
			info = "You can't do that in bed.";
			}
		else{
			outside = true;
			end = true;
			if(door and dressed)SeekEntity(id).SetSprite("clothesoutside.png");
			else if(door and !dressed)SeekEntity(id).SetSprite("nakedoutside.png");
			else if(!door and dressed)SeekEntity(id).SetSprite("clothesfaileddoor.png");
			else if(!door and !dressed)SeekEntity(id).SetSprite("faileddoor.png");
			}
		}
	else if(command == "sleep"){
		end = true;
		sleep = true;
		}
	else{
		info = "I don't understand that.";
		}
	}