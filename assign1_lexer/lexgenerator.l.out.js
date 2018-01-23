var MyLexer = (function (undefined) {
function CDFA_base(){
	this.ss=undefined;
	this.as=undefined;
	this.tt=undefined;
this.stt={};
}
CDFA_base.prototype.reset = function (state) {
	this.cs = state || 	this.ss;
this.bol=false;
};
CDFA_base.prototype.readSymbol = function (c) {
	this.cs = this.nextState(this.cs, c);
};
CDFA_base.prototype.isAccepting = function () {
	var acc = this.as.indexOf(this.cs)>=0;
if((this.stt[this.cs]===-1)&&!this.bol){
acc=false;}
return acc;};
CDFA_base.prototype.isInDeadState = function () {
	return this.cs === undefined || this.cs === 0;
};
CDFA_base.prototype.getCurrentToken = function(){
	var t= this.tt[this.cs];
var s=this.stt[this.cs];
if(s!==undefined){return this.bol?t:s;}
return t;};

function CDFA_DEFAULT(){
	this.ss=1;
	this.as=[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141];
	this.tt=[null,33,34,33,33,34,30,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,29,null,30,32,32,32,32,32,32,32,32,32,9,32,32,32,32,15,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,14,32,32,18,32,20,32,32,32,32,32,32,32,32,32,32,32,2,3,4,32,32,32,32,32,11,32,32,32,32,19,32,32,32,32,32,32,26,27,32,32,1,5,6,32,32,32,32,13,32,32,31,32,22,32,24,32,28,32,32,32,10,32,16,32,21,23,25,0,32,8,12,32,7,32,32,17];
this.stt={};
}
CDFA_DEFAULT.prototype= new CDFA_base();
CDFA_DEFAULT.prototype.nextState = function(state, c){
    var next = 0;
    switch(state){
case 1:
if((c < "\t" || "\n" < c)  && (c < "\r" || "\r" < c)  && (c < " " || " " < c)  && (c < "." || "." < c)  && (c < "0" || "9" < c)  && (c < "A" || "Z" < c)  && (c < "_" || "_" < c)  && (c < "a" || "z" < c)  && (c < " " || " " < c) ){
next = 2;
} else if(("\t" === c ) || (" " === c ) || (" " === c )){
next = 3;
} else if(("\n" === c ) || ("\r" === c )){
next = 3;
} else if(("." === c )){
next = 5;
} else if(("0" <= c && c <= "9") ){
next = 6;
} else if(("A" <= c && c <= "Z")  || ("_" === c ) || ("a" === c ) || ("g" <= c && c <= "h")  || ("j" <= c && c <= "k")  || ("m" === c ) || ("o" === c ) || ("q" === c ) || ("u" === c ) || ("x" <= c && c <= "z") ){
next = 7;
} else if(("b" === c )){
next = 8;
} else if(("c" === c )){
next = 9;
} else if(("d" === c )){
next = 10;
} else if(("e" === c )){
next = 11;
} else if(("f" === c )){
next = 12;
} else if(("i" === c )){
next = 13;
} else if(("l" === c )){
next = 14;
} else if(("n" === c )){
next = 15;
} else if(("p" === c )){
next = 16;
} else if(("r" === c )){
next = 17;
} else if(("s" === c )){
next = 18;
} else if(("t" === c )){
next = 19;
} else if(("v" === c )){
next = 20;
} else if(("w" === c )){
next = 21;
}
break;
case 3:
if(("\t" <= c && c <= "\n")  || ("\r" === c ) || (" " === c ) || (" " === c )){
next = 3;
}
break;
case 5:
if(("0" <= c && c <= "9") ){
next = 22;
}
break;
case 6:
if(("." === c )){
next = 23;
} else if(("0" <= c && c <= "9") ){
next = 6;
} else if(("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "z") ){
next = 7;
}
break;
case 7:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "z") ){
next = 7;
}
break;
case 8:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "n")  || ("p" <= c && c <= "q")  || ("s" <= c && c <= "x")  || ("z" === c )){
next = 7;
} else if(("o" === c )){
next = 26;
} else if(("r" === c )){
next = 27;
} else if(("y" === c )){
next = 28;
}
break;
case 9:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("b" <= c && c <= "g")  || ("i" <= c && c <= "k")  || ("m" <= c && c <= "n")  || ("p" <= c && c <= "z") ){
next = 7;
} else if(("a" === c )){
next = 29;
} else if(("h" === c )){
next = 30;
} else if(("l" === c )){
next = 31;
} else if(("o" === c )){
next = 32;
}
break;
case 10:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "d")  || ("f" <= c && c <= "n")  || ("p" <= c && c <= "z") ){
next = 7;
} else if(("e" === c )){
next = 33;
} else if(("o" === c )){
next = 34;
}
break;
case 11:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "k")  || ("m" <= c && c <= "w")  || ("y" <= c && c <= "z") ){
next = 7;
} else if(("l" === c )){
next = 35;
} else if(("x" === c )){
next = 36;
}
break;
case 12:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "k")  || ("m" <= c && c <= "n")  || ("p" <= c && c <= "z") ){
next = 7;
} else if(("l" === c )){
next = 37;
} else if(("o" === c )){
next = 38;
}
break;
case 13:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "e")  || ("g" <= c && c <= "l")  || ("o" <= c && c <= "z") ){
next = 7;
} else if(("f" === c )){
next = 39;
} else if(("m" === c )){
next = 40;
} else if(("n" === c )){
next = 41;
}
break;
case 14:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "n")  || ("p" <= c && c <= "z") ){
next = 7;
} else if(("o" === c )){
next = 42;
}
break;
case 15:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "d")  || ("f" <= c && c <= "z") ){
next = 7;
} else if(("e" === c )){
next = 43;
}
break;
case 16:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "q")  || ("s" <= c && c <= "z") ){
next = 7;
} else if(("r" === c )){
next = 44;
}
break;
case 17:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "d")  || ("f" <= c && c <= "z") ){
next = 7;
} else if(("e" === c )){
next = 45;
}
break;
case 18:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "g")  || ("i" <= c && c <= "s")  || ("v" === c ) || ("x" <= c && c <= "z") ){
next = 7;
} else if(("h" === c )){
next = 46;
} else if(("t" === c )){
next = 47;
} else if(("u" === c )){
next = 48;
} else if(("w" === c )){
next = 49;
}
break;
case 19:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "g")  || ("i" <= c && c <= "z") ){
next = 7;
} else if(("h" === c )){
next = 50;
}
break;
case 20:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "n")  || ("p" <= c && c <= "z") ){
next = 7;
} else if(("o" === c )){
next = 51;
}
break;
case 21:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "g")  || ("i" <= c && c <= "z") ){
next = 7;
} else if(("h" === c )){
next = 52;
}
break;
case 22:
if(("0" <= c && c <= "9") ){
next = 22;
}
break;
case 23:
if(("0" <= c && c <= "9") ){
next = 22;
}
break;
case 26:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "n")  || ("p" <= c && c <= "z") ){
next = 7;
} else if(("o" === c )){
next = 53;
}
break;
case 27:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "d")  || ("f" <= c && c <= "z") ){
next = 7;
} else if(("e" === c )){
next = 54;
}
break;
case 28:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "s")  || ("u" <= c && c <= "z") ){
next = 7;
} else if(("t" === c )){
next = 55;
}
break;
case 29:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "r")  || ("t" <= c && c <= "z") ){
next = 7;
} else if(("s" === c )){
next = 56;
}
break;
case 30:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("b" <= c && c <= "z") ){
next = 7;
} else if(("a" === c )){
next = 57;
}
break;
case 31:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("b" <= c && c <= "z") ){
next = 7;
} else if(("a" === c )){
next = 58;
}
break;
case 32:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "m")  || ("o" <= c && c <= "z") ){
next = 7;
} else if(("n" === c )){
next = 59;
}
break;
case 33:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "e")  || ("g" <= c && c <= "z") ){
next = 7;
} else if(("f" === c )){
next = 60;
}
break;
case 34:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "t")  || ("v" <= c && c <= "z") ){
next = 7;
} else if(("u" === c )){
next = 61;
}
break;
case 35:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "r")  || ("t" <= c && c <= "z") ){
next = 7;
} else if(("s" === c )){
next = 62;
}
break;
case 36:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "s")  || ("u" <= c && c <= "z") ){
next = 7;
} else if(("t" === c )){
next = 63;
}
break;
case 37:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "n")  || ("p" <= c && c <= "z") ){
next = 7;
} else if(("o" === c )){
next = 64;
}
break;
case 38:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "q")  || ("s" <= c && c <= "z") ){
next = 7;
} else if(("r" === c )){
next = 65;
}
break;
case 39:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "z") ){
next = 7;
}
break;
case 40:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "o")  || ("q" <= c && c <= "z") ){
next = 7;
} else if(("p" === c )){
next = 66;
}
break;
case 41:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "r")  || ("u" <= c && c <= "z") ){
next = 7;
} else if(("s" === c )){
next = 67;
} else if(("t" === c )){
next = 68;
}
break;
case 42:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "m")  || ("o" <= c && c <= "z") ){
next = 7;
} else if(("n" === c )){
next = 69;
}
break;
case 43:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "v")  || ("x" <= c && c <= "z") ){
next = 7;
} else if(("w" === c )){
next = 70;
}
break;
case 44:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "h")  || ("j" <= c && c <= "z") ){
next = 7;
} else if(("i" === c )){
next = 71;
}
break;
case 45:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "s")  || ("u" <= c && c <= "z") ){
next = 7;
} else if(("t" === c )){
next = 72;
}
break;
case 46:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "n")  || ("p" <= c && c <= "z") ){
next = 7;
} else if(("o" === c )){
next = 73;
}
break;
case 47:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("b" <= c && c <= "z") ){
next = 7;
} else if(("a" === c )){
next = 74;
}
break;
case 48:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "o")  || ("q" <= c && c <= "z") ){
next = 7;
} else if(("p" === c )){
next = 75;
}
break;
case 49:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "h")  || ("j" <= c && c <= "z") ){
next = 7;
} else if(("i" === c )){
next = 76;
}
break;
case 50:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "h")  || ("j" <= c && c <= "z") ){
next = 7;
} else if(("i" === c )){
next = 77;
}
break;
case 51:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "h")  || ("j" <= c && c <= "z") ){
next = 7;
} else if(("i" === c )){
next = 78;
}
break;
case 52:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "h")  || ("j" <= c && c <= "z") ){
next = 7;
} else if(("i" === c )){
next = 79;
}
break;
case 53:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "k")  || ("m" <= c && c <= "z") ){
next = 7;
} else if(("l" === c )){
next = 80;
}
break;
case 54:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("b" <= c && c <= "z") ){
next = 7;
} else if(("a" === c )){
next = 81;
}
break;
case 55:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "d")  || ("f" <= c && c <= "z") ){
next = 7;
} else if(("e" === c )){
next = 82;
}
break;
case 56:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "d")  || ("f" <= c && c <= "z") ){
next = 7;
} else if(("e" === c )){
next = 83;
}
break;
case 57:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "q")  || ("s" <= c && c <= "z") ){
next = 7;
} else if(("r" === c )){
next = 84;
}
break;
case 58:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "r")  || ("t" <= c && c <= "z") ){
next = 7;
} else if(("s" === c )){
next = 85;
}
break;
case 59:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "r")  || ("u" <= c && c <= "z") ){
next = 7;
} else if(("s" === c )){
next = 86;
} else if(("t" === c )){
next = 87;
}
break;
case 60:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("b" <= c && c <= "z") ){
next = 7;
} else if(("a" === c )){
next = 88;
}
break;
case 61:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" === c ) || ("c" <= c && c <= "z") ){
next = 7;
} else if(("b" === c )){
next = 89;
}
break;
case 62:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "d")  || ("f" <= c && c <= "z") ){
next = 7;
} else if(("e" === c )){
next = 90;
}
break;
case 63:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "d")  || ("f" <= c && c <= "z") ){
next = 7;
} else if(("e" === c )){
next = 91;
}
break;
case 64:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("b" <= c && c <= "z") ){
next = 7;
} else if(("a" === c )){
next = 92;
}
break;
case 65:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "z") ){
next = 7;
}
break;
case 66:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "n")  || ("p" <= c && c <= "z") ){
next = 7;
} else if(("o" === c )){
next = 93;
}
break;
case 67:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "s")  || ("u" <= c && c <= "z") ){
next = 7;
} else if(("t" === c )){
next = 94;
}
break;
case 68:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "z") ){
next = 7;
}
break;
case 69:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "f")  || ("h" <= c && c <= "z") ){
next = 7;
} else if(("g" === c )){
next = 95;
}
break;
case 70:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "z") ){
next = 7;
}
break;
case 71:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "m")  || ("o" <= c && c <= "z") ){
next = 7;
} else if(("n" === c )){
next = 96;
}
break;
case 72:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "t")  || ("v" <= c && c <= "z") ){
next = 7;
} else if(("u" === c )){
next = 97;
}
break;
case 73:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "q")  || ("s" <= c && c <= "z") ){
next = 7;
} else if(("r" === c )){
next = 98;
}
break;
case 74:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "s")  || ("u" <= c && c <= "z") ){
next = 7;
} else if(("t" === c )){
next = 99;
}
break;
case 75:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "d")  || ("f" <= c && c <= "z") ){
next = 7;
} else if(("e" === c )){
next = 100;
}
break;
case 76:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "s")  || ("u" <= c && c <= "z") ){
next = 7;
} else if(("t" === c )){
next = 101;
}
break;
case 77:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "r")  || ("t" <= c && c <= "z") ){
next = 7;
} else if(("s" === c )){
next = 102;
}
break;
case 78:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "c")  || ("e" <= c && c <= "z") ){
next = 7;
} else if(("d" === c )){
next = 103;
}
break;
case 79:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "k")  || ("m" <= c && c <= "z") ){
next = 7;
} else if(("l" === c )){
next = 104;
}
break;
case 80:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "d")  || ("f" <= c && c <= "z") ){
next = 7;
} else if(("e" === c )){
next = 105;
}
break;
case 81:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "j")  || ("l" <= c && c <= "z") ){
next = 7;
} else if(("k" === c )){
next = 106;
}
break;
case 82:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "z") ){
next = 7;
}
break;
case 83:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "z") ){
next = 7;
}
break;
case 84:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "z") ){
next = 7;
}
break;
case 85:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "r")  || ("t" <= c && c <= "z") ){
next = 7;
} else if(("s" === c )){
next = 107;
}
break;
case 86:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "s")  || ("u" <= c && c <= "z") ){
next = 7;
} else if(("t" === c )){
next = 108;
}
break;
case 87:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "h")  || ("j" <= c && c <= "z") ){
next = 7;
} else if(("i" === c )){
next = 109;
}
break;
case 88:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "t")  || ("v" <= c && c <= "z") ){
next = 7;
} else if(("u" === c )){
next = 110;
}
break;
case 89:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "k")  || ("m" <= c && c <= "z") ){
next = 7;
} else if(("l" === c )){
next = 111;
}
break;
case 90:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "z") ){
next = 7;
}
break;
case 91:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "m")  || ("o" <= c && c <= "z") ){
next = 7;
} else if(("n" === c )){
next = 112;
}
break;
case 92:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "s")  || ("u" <= c && c <= "z") ){
next = 7;
} else if(("t" === c )){
next = 113;
}
break;
case 93:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "q")  || ("s" <= c && c <= "z") ){
next = 7;
} else if(("r" === c )){
next = 114;
}
break;
case 94:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("b" <= c && c <= "z") ){
next = 7;
} else if(("a" === c )){
next = 115;
}
break;
case 95:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "z") ){
next = 7;
}
break;
case 96:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "s")  || ("u" <= c && c <= "z") ){
next = 7;
} else if(("t" === c )){
next = 116;
}
break;
case 97:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "q")  || ("s" <= c && c <= "z") ){
next = 7;
} else if(("r" === c )){
next = 117;
}
break;
case 98:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "s")  || ("u" <= c && c <= "z") ){
next = 7;
} else if(("t" === c )){
next = 118;
}
break;
case 99:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "h")  || ("j" <= c && c <= "z") ){
next = 7;
} else if(("i" === c )){
next = 119;
}
break;
case 100:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "q")  || ("s" <= c && c <= "z") ){
next = 7;
} else if(("r" === c )){
next = 120;
}
break;
case 101:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "b")  || ("d" <= c && c <= "z") ){
next = 7;
} else if(("c" === c )){
next = 121;
}
break;
case 102:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "z") ){
next = 7;
}
break;
case 103:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "z") ){
next = 7;
}
break;
case 104:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "d")  || ("f" <= c && c <= "z") ){
next = 7;
} else if(("e" === c )){
next = 122;
}
break;
case 105:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("b" <= c && c <= "z") ){
next = 7;
} else if(("a" === c )){
next = 123;
}
break;
case 106:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "z") ){
next = 7;
}
break;
case 107:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "z") ){
next = 7;
}
break;
case 108:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "z") ){
next = 7;
}
break;
case 109:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "m")  || ("o" <= c && c <= "z") ){
next = 7;
} else if(("n" === c )){
next = 124;
}
break;
case 110:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "k")  || ("m" <= c && c <= "z") ){
next = 7;
} else if(("l" === c )){
next = 125;
}
break;
case 111:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "d")  || ("f" <= c && c <= "z") ){
next = 7;
} else if(("e" === c )){
next = 126;
}
break;
case 112:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "c")  || ("e" <= c && c <= "z") ){
next = 7;
} else if(("d" === c )){
next = 127;
}
break;
case 113:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "z") ){
next = 7;
}
break;
case 114:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "s")  || ("u" <= c && c <= "z") ){
next = 7;
} else if(("t" === c )){
next = 128;
}
break;
case 115:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "m")  || ("o" <= c && c <= "z") ){
next = 7;
} else if(("n" === c )){
next = 129;
}
break;
case 116:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "z") ){
next = 7;
}
break;
case 117:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "m")  || ("o" <= c && c <= "z") ){
next = 7;
} else if(("n" === c )){
next = 130;
}
break;
case 118:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "z") ){
next = 7;
}
break;
case 119:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "b")  || ("d" <= c && c <= "z") ){
next = 7;
} else if(("c" === c )){
next = 131;
}
break;
case 120:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "z") ){
next = 7;
}
break;
case 121:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "g")  || ("i" <= c && c <= "z") ){
next = 7;
} else if(("h" === c )){
next = 132;
}
break;
case 122:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "z") ){
next = 7;
}
break;
case 123:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "m")  || ("o" <= c && c <= "z") ){
next = 7;
} else if(("n" === c )){
next = 133;
}
break;
case 124:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "t")  || ("v" <= c && c <= "z") ){
next = 7;
} else if(("u" === c )){
next = 134;
}
break;
case 125:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "s")  || ("u" <= c && c <= "z") ){
next = 7;
} else if(("t" === c )){
next = 135;
}
break;
case 126:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "z") ){
next = 7;
}
break;
case 127:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "r")  || ("t" <= c && c <= "z") ){
next = 7;
} else if(("s" === c )){
next = 136;
}
break;
case 128:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "z") ){
next = 7;
}
break;
case 129:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "b")  || ("d" <= c && c <= "z") ){
next = 7;
} else if(("c" === c )){
next = 137;
}
break;
case 130:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "z") ){
next = 7;
}
break;
case 131:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "z") ){
next = 7;
}
break;
case 132:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "z") ){
next = 7;
}
break;
case 133:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "z") ){
next = 7;
}
break;
case 134:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "d")  || ("f" <= c && c <= "z") ){
next = 7;
} else if(("e" === c )){
next = 138;
}
break;
case 135:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "z") ){
next = 7;
}
break;
case 136:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "z") ){
next = 7;
}
break;
case 137:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "d")  || ("f" <= c && c <= "z") ){
next = 7;
} else if(("e" === c )){
next = 139;
}
break;
case 138:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "z") ){
next = 7;
}
break;
case 139:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "n")  || ("p" <= c && c <= "z") ){
next = 7;
} else if(("o" === c )){
next = 140;
}
break;
case 140:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "e")  || ("g" <= c && c <= "z") ){
next = 7;
} else if(("f" === c )){
next = 141;
}
break;
case 141:
if(("0" <= c && c <= "9")  || ("A" <= c && c <= "Z")  || ("_" === c ) || ("a" <= c && c <= "z") ){
next = 7;
}
break;
	}
	return next;
};

var EOF={};
function Lexer(){

if(!(this instanceof Lexer)) return new Lexer();

this.pos={line:0,col:0};

this.states={};
this.state = ['DEFAULT'];
this.lastChar = '\n';
this.actions = [function anonymous() {

    // this.jjval = String(this.jjtext);
    return 'keyword_boolean';

},function anonymous() {

    this.jjval = String(this.jjtext);
    return 'keyword_break';

},function anonymous() {

    // this.jjval = String(this.jjtext);
    return 'keyword_byte';

},function anonymous() {

    // this.jjval = String(this.jjtext);
    return 'keyword_case';

},function anonymous() {

    // this.jjval = String(this.jjtext);
    return 'keyword_char';

},function anonymous() {

    // this.jjval = String(this.jjtext);
    return 'keyword_class';

},function anonymous() {

    // this.jjval = String(this.jjtext);
    return 'keyword_const';

},function anonymous() {

    // this.jjval = String(this.jjtext);
    return 'keyword_continue';

},function anonymous() {

    // this.jjval = String(this.jjtext);
    return 'keyword_default';

},function anonymous() {

    // this.jjval = String(this.jjtext);
    return 'keyword_do';

},function anonymous() {

    // this.jjval = String(this.jjtext);
    return 'keyword_double';

},function anonymous() {

    // this.jjval = String(this.jjtext);
    return 'keyword_else';

},function anonymous() {

    // this.jjval = String(this.jjtext);
    return 'keyword_extends';

},function anonymous() {

    // this.jjval = String(this.jjtext);
    return 'keyword_float';

},function anonymous() {

    // this.jjval = String(this.jjtext);
    return 'keyword_for';

},function anonymous() {

    // this.jjval = String(this.jjtext);
    return 'keyword_if';

},function anonymous() {

    // this.jjval = String(this.jjtext);
    return 'keyword_import';

},function anonymous() {

    // this.jjval = String(this.jjtext);
    return 'keyword_instanceof';

},function anonymous() {

    // this.jjval = String(this.jjtext);
    return 'keyword_int';

},function anonymous() {

    // this.jjval = String(this.jjtext);
    return 'keyword_long';

},function anonymous() {

    // this.jjval = String(this.jjtext);
    return 'keyword_new';

},function anonymous() {

    // this.jjval = String(this.jjtext);
    return 'keyword_return';

},function anonymous() {

    // this.jjval = String(this.jjtext);
    return 'keyword_short';

},function anonymous() {

    // this.jjval = String(this.jjtext);
    return 'keyword_static';

},function anonymous() {

    // this.jjval = String(this.jjtext);
    return 'keyword_super';

},function anonymous() {

    // this.jjval = String(this.jjtext);
    return 'keyword_switch';

},function anonymous() {

    // this.jjval = String(this.jjtext);
    return 'keyword_this';

},function anonymous() {

    // this.jjval = String(this.jjtext);
    return 'keyword_void';

},function anonymous() {

    // this.jjval = String(this.jjtext);
    return 'keyword_while';

},function anonymous() {

    this.jjval = parseFloat(this.jjtext);
    return 'float';

},function anonymous() {

    this.jjval = parseInt(this.jjtext);
    return 'integer';

},function anonymous() {

  return 'print';

},function anonymous() {
 return 'id'; 
},function anonymous() {
 
},function anonymous() {
 return this.jjtext; 
},function anonymous() {
 console.log('EOF'); return 'EOF'; 
}];
this.states["DEFAULT"] = {};
this.states["DEFAULT"].dfa = new CDFA_DEFAULT();
}
Lexer.prototype.setInput=function (input){
        this.pos={row:0, col:0};
        if(typeof input === 'string')
        {input = new StringReader(input);}
        this.input = input;
        this.state = ['DEFAULT'];
        this.lastChar='\n';
        this.getDFA().reset();
        return this;
    };
Lexer.prototype.nextToken=function () {


        var ret = undefined;
        while(ret === undefined){
            this.resetToken();
            ret = this.more();
        }


        if (ret === EOF) {
            this.current = EOF;
        } else {
            this.current = {};
            this.current.name = ret;
            this.current.value = this.jjval;
            this.current.lexeme = this.jjtext;
            this.current.position = this.jjpos;
            this.current.pos = {col: this.jjcol, line: this.jjline};
        }
        return this.current;
    };
Lexer.prototype.resetToken=function (){
        this.getDFA().reset();
        this.getDFA().bol = (this.lastChar === '\n');
        this.lastValid = undefined;
        this.lastValidPos = -1;
        this.jjtext = '';
        this.remains = '';
        this.buffer = '';
        this.startpos = this.input.getPos();
        this.jjline = this.input.line;
        this.jjcol = this.input.col;
    };
Lexer.prototype.halt=function () {
        if (this.lastValidPos >= 0) {
            var lastValidLength = this.lastValidPos-this.startpos+1;
            this.jjtext = this.buffer.substring(0, lastValidLength);
            this.remains = this.buffer.substring(lastValidLength);
            this.jjval = this.jjtext;
            this.jjpos = this.lastValidPos + 1-this.jjtext.length;
            this.input.rollback(this.remains);
            var action = this.getAction(this.lastValid);
            if (typeof ( action) === 'function') {
                return action.call(this);
            }
            this.resetToken();
        }
        else if(!this.input.more()){//EOF
            var actionid = this.states[this.getState()].eofaction;
            if(actionid){
                action = this.getAction(actionid);
                if (typeof ( action) === 'function') {
                    //Note we don't care of returned token, must return 'EOF'
                    action.call(this);
                }
            }
            return EOF;
        } else {//Unexpected character
            throw new Error('Unexpected char \''+this.input.peek()+'\' at '+this.jjline +':'+this.jjcol);
        }
    };
Lexer.prototype.more=function (){
        var ret;
        while (this.input.more()) {
            var c = this.input.peek();
            this.getDFA().readSymbol(c);
            if (this.getDFA().isInDeadState()) {

                ret = this.halt();
                return ret;

            } else {
                if (this.getDFA().isAccepting()) {
                    this.lastValid = this.getDFA().getCurrentToken();
                    this.lastValidPos = this.input.getPos();

                }
                this.buffer = this.buffer + c;
                this.lastChar = c;
                this.input.next();
            }

        }
        ret = this.halt();
        return ret;
    };
Lexer.prototype.less=function (length){
        this.input.rollback(length);
    };
Lexer.prototype.getDFA=function (){
        return this.states[this.getState()].dfa;
    };
Lexer.prototype.getAction=function (i){
        return this.actions[i];
    };
Lexer.prototype.pushState=function (state){
        this.state.push(state);
        this.getDFA().reset();
    };
Lexer.prototype.popState=function (){
        if(this.state.length>1) {
            this.state.pop();
            this.getDFA().reset();
        }
    };
Lexer.prototype.getState=function (){
        return this.state[this.state.length-1];
    };
Lexer.prototype.restoreLookAhead=function (){
        this.tailLength = this.jjtext.length;
        this.popState();
        this.less(this.tailLength);
        this.jjtext = this.lawhole.substring(0,this.lawhole.length-this.tailLength);


    };
Lexer.prototype.evictTail=function (length){
        this.less(length);
        this.jjtext = this.jjtext.substring(0,this.jjtext.length-length);
    };
Lexer.prototype.isEOF=function (o){
        return o===EOF;
    }
;
function StringReader(str){
        if(!(this instanceof StringReader)) return new StringReader(str);
		this.str = str;
		this.pos = 0;
        this.line = 0;
        this.col = 0;
	}
StringReader.prototype.getPos=function (){
        return this.pos;
    };
StringReader.prototype.peek=function ()
	{
		//TODO: handle EOF
		return this.str.charAt(this.pos);
	};
StringReader.prototype.eat=function (str)
	{
		var istr = this.str.substring(this.pos,this.pos+str.length);
		if(istr===str){
			this.pos+=str.length;
            this.updatePos(str,1);
		} else {
			throw new Error('Expected "'+str+'", got "'+istr+'"!');
		}
	};
StringReader.prototype.updatePos=function (str,delta){
        for(var i=0;i<str.length;i++){
            if(str[i]=='\n'){
                this.col=0;
                this.line+=delta;
            }else{
                this.col+=delta;
            }
        }
    };
StringReader.prototype.rollback=function (str)
    {
        if(typeof str === 'string')
        {
            var istr = this.str.substring(this.pos-str.length,this.pos);
            if(istr===str){
                this.pos-=str.length;
                this.updatePos(str,-1);
            } else {
                throw new Error('Expected "'+str+'", got "'+istr+'"!');
            }
        } else {
            this.pos-=str;
            this.updatePos(str,-1);
        }

    };
StringReader.prototype.next=function ()
	{
		var s = this.str.charAt(this.pos);
		this.pos=this.pos+1;
		this.updatePos(s,1);
		return s;
	};
StringReader.prototype.more=function ()
	{
		return this.pos<this.str.length;
	};
StringReader.prototype.reset=function (){
        this.pos=0;
    };
if (typeof(module) !== 'undefined') { module.exports = Lexer; }
return Lexer;})();