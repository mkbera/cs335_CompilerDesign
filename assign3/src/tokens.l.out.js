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
	this.as=[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,48,50,51,52,53,54,55,56,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,108,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210];
	this.tt=[null,82,83,82,82,60,83,68,36,58,83,72,73,34,32,71,33,70,35,63,69,54,55,53,68,74,75,61,68,68,68,68,68,68,68,68,68,68,68,68,68,68,68,76,59,77,45,null,66,null,68,68,68,68,41,56,42,null,null,39,30,37,31,38,79,78,40,62,63,51,50,46,49,52,44,68,68,68,68,68,68,68,68,9,68,68,68,68,68,15,68,68,68,68,68,68,68,68,68,68,68,68,68,68,68,43,57,null,67,null,78,62,47,48,68,68,68,68,68,68,68,68,68,68,68,68,68,14,68,68,18,68,20,68,68,68,68,68,68,68,68,68,68,68,68,68,2,3,4,68,68,68,68,68,11,68,68,68,68,68,19,65,68,68,68,68,68,68,27,64,28,68,68,1,5,6,68,68,68,68,64,13,68,68,68,68,23,68,25,68,29,68,68,68,10,68,16,68,21,22,24,26,0,68,8,12,68,7,68,68,17];
this.stt={};
}
CDFA_DEFAULT.prototype= new CDFA_base();
CDFA_DEFAULT.prototype.nextState = function(state, c){
    var next = 0;
    switch(state){
case 1:
if((c < "\t" || "\n" < c)  && (c < "\r" || "\r" < c)  && (c < " " || "\"" < c)  && (c < "$" || "9" < c)  && (c < ";" || ">" < c)  && (c < "A" || "[" < c)  && (c < "]" || "_" < c)  && (c < "a" || "}" < c)  && (c < " " || " " < c) ){
next = 2;
} else if(("\t" === c ) || (" " === c ) || (" " === c )){
next = 3;
} else if(("\n" === c ) || ("\r" === c )){
next = 3;
} else if(("!" === c )){
next = 5;
} else if(("\"" === c )){
next = 6;
} else if(("$" === c )){
next = 7;
} else if(("%" === c )){
next = 8;
} else if(("&" === c )){
next = 9;
} else if(("'" === c )){
next = 10;
} else if(("(" === c )){
next = 11;
} else if((")" === c )){
next = 12;
} else if(("*" === c )){
next = 13;
} else if(("+" === c )){
next = 14;
} else if(("," === c )){
next = 15;
} else if(("-" === c )){
next = 16;
} else if(("." === c )){
next = 17;
} else if(("/" === c )){
next = 18;
} else if(("0" <= c && c <= "9") ){
next = 19;
} else if((";" === c )){
next = 20;
} else if(("<" === c )){
next = 21;
} else if(("=" === c )){
next = 22;
} else if((">" === c )){
next = 23;
} else if(("A" <= c && c <= "Z")  || ("a" === c ) || ("g" <= c && c <= "h")  || ("j" <= c && c <= "k")  || ("m" === c ) || ("o" === c ) || ("q" === c ) || ("u" === c ) || ("x" <= c && c <= "z") ){
next = 7;
} else if(("[" === c )){
next = 25;
} else if(("]" === c )){
next = 26;
} else if(("^" === c )){
next = 27;
} else if(("_" === c )){
next = 7;
} else if(("b" === c )){
next = 29;
} else if(("c" === c )){
next = 30;
} else if(("d" === c )){
next = 31;
} else if(("e" === c )){
next = 32;
} else if(("f" === c )){
next = 33;
} else if(("i" === c )){
next = 34;
} else if(("l" === c )){
next = 35;
} else if(("n" === c )){
next = 36;
} else if(("p" === c )){
next = 37;
} else if(("r" === c )){
next = 38;
} else if(("s" === c )){
next = 39;
} else if(("t" === c )){
next = 40;
} else if(("v" === c )){
next = 41;
} else if(("w" === c )){
next = 42;
} else if(("{" === c )){
next = 43;
} else if(("|" === c )){
next = 44;
} else if(("}" === c )){
next = 45;
}
break;
case 3:
if(("\t" <= c && c <= "\n")  || ("\r" === c ) || (" " === c ) || (" " === c )){
next = 3;
}
break;
case 5:
if(("=" === c )){
next = 46;
}
break;
case 6:
if((c < "\"" || "\"" < c)  && (c < "\\" || "\\" < c) ){
next = 47;
} else if(("\"" === c )){
next = 48;
} else if(("\\" === c )){
next = 49;
}
break;
case 7:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
}
break;
case 8:
if(("=" === c )){
next = 54;
}
break;
case 9:
if(("&" === c )){
next = 55;
} else if(("=" === c )){
next = 56;
}
break;
case 10:
if((c < "'" || "'" < c)  && (c < "\\" || "\\" < c) ){
next = 57;
} else if(("\\" === c )){
next = 58;
}
break;
case 13:
if(("=" === c )){
next = 59;
}
break;
case 14:
if(("+" === c )){
next = 60;
} else if(("=" === c )){
next = 61;
}
break;
case 16:
if(("-" === c )){
next = 62;
} else if(("=" === c )){
next = 63;
}
break;
case 18:
if(("*" === c )){
next = 64;
} else if(("/" === c )){
next = 65;
} else if(("=" === c )){
next = 66;
}
break;
case 19:
if(("." === c )){
next = 67;
} else if(("0" <= c && c <= "9") ){
next = 19;
}
break;
case 21:
if(("<" === c )){
next = 69;
} else if(("=" === c )){
next = 70;
}
break;
case 22:
if(("=" === c )){
next = 71;
}
break;
case 23:
if(("=" === c )){
next = 72;
} else if((">" === c )){
next = 73;
}
break;
case 27:
if(("=" === c )){
next = 74;
}
break;
case 29:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "n")  || ("p" <= c && c <= "q")  || ("s" <= c && c <= "x")  || ("z" === c )){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("o" === c )){
next = 75;
} else if(("r" === c )){
next = 76;
} else if(("y" === c )){
next = 77;
}
break;
case 30:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("b" <= c && c <= "g")  || ("i" <= c && c <= "k")  || ("m" <= c && c <= "n")  || ("p" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("a" === c )){
next = 78;
} else if(("h" === c )){
next = 79;
} else if(("l" === c )){
next = 80;
} else if(("o" === c )){
next = 81;
}
break;
case 31:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "d")  || ("f" <= c && c <= "n")  || ("p" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("e" === c )){
next = 82;
} else if(("o" === c )){
next = 83;
}
break;
case 32:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "k")  || ("m" <= c && c <= "w")  || ("y" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("l" === c )){
next = 84;
} else if(("x" === c )){
next = 85;
}
break;
case 33:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("b" <= c && c <= "k")  || ("m" <= c && c <= "n")  || ("p" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("a" === c )){
next = 86;
} else if(("l" === c )){
next = 87;
} else if(("o" === c )){
next = 88;
}
break;
case 34:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "e")  || ("g" <= c && c <= "l")  || ("o" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("f" === c )){
next = 89;
} else if(("m" === c )){
next = 90;
} else if(("n" === c )){
next = 91;
}
break;
case 35:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "n")  || ("p" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("o" === c )){
next = 92;
}
break;
case 36:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "d")  || ("f" <= c && c <= "t")  || ("v" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("e" === c )){
next = 93;
} else if(("u" === c )){
next = 94;
}
break;
case 37:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "t")  || ("v" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("u" === c )){
next = 95;
}
break;
case 38:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "d")  || ("f" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("e" === c )){
next = 96;
}
break;
case 39:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "g")  || ("i" <= c && c <= "s")  || ("v" === c ) || ("x" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("h" === c )){
next = 97;
} else if(("t" === c )){
next = 98;
} else if(("u" === c )){
next = 99;
} else if(("w" === c )){
next = 100;
}
break;
case 40:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "g")  || ("i" <= c && c <= "q")  || ("s" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("h" === c )){
next = 101;
} else if(("r" === c )){
next = 102;
}
break;
case 41:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "n")  || ("p" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("o" === c )){
next = 103;
}
break;
case 42:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "g")  || ("i" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("h" === c )){
next = 104;
}
break;
case 44:
if(("=" === c )){
next = 105;
} else if(("|" === c )){
next = 106;
}
break;
case 47:
if((c < "\"" || "\"" < c)  && (c < "\\" || "\\" < c) ){
next = 47;
} else if(("\"" === c )){
next = 48;
} else if(("\\" === c )){
next = 49;
}
break;
case 49:
if((c < "\n" || "\n" < c)  && (c < "\r" || "\r" < c) ){
next = 47;
}
break;
case 57:
if(("'" === c )){
next = 108;
}
break;
case 58:
if((c < "\n" || "\n" < c)  && (c < "\r" || "\r" < c) ){
next = 57;
}
break;
case 65:
if((c < "\n" || "\n" < c)  && (c < "\r" || "\r" < c) ){
next = 65;
}
break;
case 67:
if(("0" <= c && c <= "9") ){
next = 67;
}
break;
case 69:
if(("=" === c )){
next = 112;
}
break;
case 73:
if(("=" === c )){
next = 113;
}
break;
case 75:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "n")  || ("p" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("o" === c )){
next = 114;
}
break;
case 76:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "d")  || ("f" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("e" === c )){
next = 115;
}
break;
case 77:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "s")  || ("u" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("t" === c )){
next = 116;
}
break;
case 78:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "r")  || ("t" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("s" === c )){
next = 117;
}
break;
case 79:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("b" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("a" === c )){
next = 118;
}
break;
case 80:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("b" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("a" === c )){
next = 119;
}
break;
case 81:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "m")  || ("o" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("n" === c )){
next = 120;
}
break;
case 82:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "e")  || ("g" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("f" === c )){
next = 121;
}
break;
case 83:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "t")  || ("v" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("u" === c )){
next = 122;
}
break;
case 84:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "r")  || ("t" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("s" === c )){
next = 123;
}
break;
case 85:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "s")  || ("u" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("t" === c )){
next = 124;
}
break;
case 86:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "k")  || ("m" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("l" === c )){
next = 125;
}
break;
case 87:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "n")  || ("p" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("o" === c )){
next = 126;
}
break;
case 88:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "q")  || ("s" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("r" === c )){
next = 127;
}
break;
case 89:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
}
break;
case 90:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "o")  || ("q" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("p" === c )){
next = 128;
}
break;
case 91:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "r")  || ("u" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("s" === c )){
next = 129;
} else if(("t" === c )){
next = 130;
}
break;
case 92:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "m")  || ("o" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("n" === c )){
next = 131;
}
break;
case 93:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "v")  || ("x" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("w" === c )){
next = 132;
}
break;
case 94:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "k")  || ("m" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("l" === c )){
next = 133;
}
break;
case 95:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" === c ) || ("c" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("b" === c )){
next = 134;
}
break;
case 96:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "s")  || ("u" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("t" === c )){
next = 135;
}
break;
case 97:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "n")  || ("p" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("o" === c )){
next = 136;
}
break;
case 98:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("b" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("a" === c )){
next = 137;
}
break;
case 99:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "o")  || ("q" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("p" === c )){
next = 138;
}
break;
case 100:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "h")  || ("j" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("i" === c )){
next = 139;
}
break;
case 101:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "h")  || ("j" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("i" === c )){
next = 140;
}
break;
case 102:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "t")  || ("v" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("u" === c )){
next = 141;
}
break;
case 103:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "h")  || ("j" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("i" === c )){
next = 142;
}
break;
case 104:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "h")  || ("j" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("i" === c )){
next = 143;
}
break;
case 114:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "k")  || ("m" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("l" === c )){
next = 144;
}
break;
case 115:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("b" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("a" === c )){
next = 145;
}
break;
case 116:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "d")  || ("f" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("e" === c )){
next = 146;
}
break;
case 117:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "d")  || ("f" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("e" === c )){
next = 147;
}
break;
case 118:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "q")  || ("s" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("r" === c )){
next = 148;
}
break;
case 119:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "r")  || ("t" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("s" === c )){
next = 149;
}
break;
case 120:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "r")  || ("u" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("s" === c )){
next = 150;
} else if(("t" === c )){
next = 151;
}
break;
case 121:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("b" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("a" === c )){
next = 152;
}
break;
case 122:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" === c ) || ("c" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("b" === c )){
next = 153;
}
break;
case 123:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "d")  || ("f" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("e" === c )){
next = 154;
}
break;
case 124:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "d")  || ("f" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("e" === c )){
next = 155;
}
break;
case 125:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "r")  || ("t" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("s" === c )){
next = 141;
}
break;
case 126:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("b" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("a" === c )){
next = 157;
}
break;
case 127:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
}
break;
case 128:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "n")  || ("p" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("o" === c )){
next = 158;
}
break;
case 129:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "s")  || ("u" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("t" === c )){
next = 159;
}
break;
case 130:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
}
break;
case 131:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "f")  || ("h" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("g" === c )){
next = 160;
}
break;
case 132:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
}
break;
case 133:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "k")  || ("m" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("l" === c )){
next = 161;
}
break;
case 134:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "k")  || ("m" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("l" === c )){
next = 162;
}
break;
case 135:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "t")  || ("v" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("u" === c )){
next = 163;
}
break;
case 136:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "q")  || ("s" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("r" === c )){
next = 164;
}
break;
case 137:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "s")  || ("u" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("t" === c )){
next = 165;
}
break;
case 138:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "d")  || ("f" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("e" === c )){
next = 166;
}
break;
case 139:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "s")  || ("u" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("t" === c )){
next = 167;
}
break;
case 140:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "r")  || ("t" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("s" === c )){
next = 168;
}
break;
case 141:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "d")  || ("f" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("e" === c )){
next = 169;
}
break;
case 142:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "c")  || ("e" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("d" === c )){
next = 170;
}
break;
case 143:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "k")  || ("m" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("l" === c )){
next = 171;
}
break;
case 144:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "d")  || ("f" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("e" === c )){
next = 172;
}
break;
case 145:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "j")  || ("l" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("k" === c )){
next = 173;
}
break;
case 146:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
}
break;
case 147:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
}
break;
case 148:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
}
break;
case 149:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "r")  || ("t" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("s" === c )){
next = 174;
}
break;
case 150:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "s")  || ("u" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("t" === c )){
next = 175;
}
break;
case 151:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "h")  || ("j" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("i" === c )){
next = 176;
}
break;
case 152:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "t")  || ("v" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("u" === c )){
next = 177;
}
break;
case 153:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "k")  || ("m" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("l" === c )){
next = 178;
}
break;
case 154:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
}
break;
case 155:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "m")  || ("o" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("n" === c )){
next = 179;
}
break;
case 157:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "s")  || ("u" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("t" === c )){
next = 181;
}
break;
case 158:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "q")  || ("s" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("r" === c )){
next = 182;
}
break;
case 159:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("b" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("a" === c )){
next = 183;
}
break;
case 160:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
}
break;
case 161:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
}
break;
case 162:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "h")  || ("j" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("i" === c )){
next = 184;
}
break;
case 163:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "q")  || ("s" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("r" === c )){
next = 185;
}
break;
case 164:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "s")  || ("u" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("t" === c )){
next = 186;
}
break;
case 165:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "h")  || ("j" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("i" === c )){
next = 187;
}
break;
case 166:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "q")  || ("s" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("r" === c )){
next = 188;
}
break;
case 167:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "b")  || ("d" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("c" === c )){
next = 189;
}
break;
case 168:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
}
break;
case 169:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
}
break;
case 170:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
}
break;
case 171:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "d")  || ("f" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("e" === c )){
next = 190;
}
break;
case 172:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("b" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("a" === c )){
next = 191;
}
break;
case 173:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
}
break;
case 174:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
}
break;
case 175:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
}
break;
case 176:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "m")  || ("o" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("n" === c )){
next = 192;
}
break;
case 177:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "k")  || ("m" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("l" === c )){
next = 193;
}
break;
case 178:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "d")  || ("f" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("e" === c )){
next = 194;
}
break;
case 179:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "c")  || ("e" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("d" === c )){
next = 195;
}
break;
case 181:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
}
break;
case 182:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "s")  || ("u" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("t" === c )){
next = 196;
}
break;
case 183:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "m")  || ("o" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("n" === c )){
next = 197;
}
break;
case 184:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "b")  || ("d" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("c" === c )){
next = 198;
}
break;
case 185:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "m")  || ("o" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("n" === c )){
next = 199;
}
break;
case 186:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
}
break;
case 187:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "b")  || ("d" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("c" === c )){
next = 200;
}
break;
case 188:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
}
break;
case 189:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "g")  || ("i" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("h" === c )){
next = 201;
}
break;
case 190:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
}
break;
case 191:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "m")  || ("o" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("n" === c )){
next = 202;
}
break;
case 192:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "t")  || ("v" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("u" === c )){
next = 203;
}
break;
case 193:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "s")  || ("u" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("t" === c )){
next = 204;
}
break;
case 194:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
}
break;
case 195:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "r")  || ("t" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("s" === c )){
next = 205;
}
break;
case 196:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
}
break;
case 197:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "b")  || ("d" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("c" === c )){
next = 206;
}
break;
case 198:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
}
break;
case 199:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
}
break;
case 200:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
}
break;
case 201:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
}
break;
case 202:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
}
break;
case 203:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "d")  || ("f" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("e" === c )){
next = 207;
}
break;
case 204:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
}
break;
case 205:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
}
break;
case 206:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "d")  || ("f" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("e" === c )){
next = 208;
}
break;
case 207:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
}
break;
case 208:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "n")  || ("p" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("o" === c )){
next = 209;
}
break;
case 209:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "e")  || ("g" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
} else if(("f" === c )){
next = 210;
}
break;
case 210:
if(("$" === c )){
next = 7;
} else if(("0" <= c && c <= "9") ){
next = 7;
} else if(("A" <= c && c <= "Z")  || ("a" <= c && c <= "z") ){
next = 7;
} else if(("_" === c )){
next = 7;
}
break;
	}
	return next;
};

function CDFA_BLOCKCOMMENT(){
	this.ss=1;
	this.as=[2,3,4,5,6];
	this.tt=[null,null,81,81,81,81,80];
this.stt={};
}
CDFA_BLOCKCOMMENT.prototype= new CDFA_base();
CDFA_BLOCKCOMMENT.prototype.nextState = function(state, c){
    var next = 0;
    switch(state){
case 1:
if((c < "\n" || "\n" < c)  && (c < "\r" || "\r" < c)  && (c < "*" || "*" < c) ){
next = 2;
} else if(("\n" === c )){
next = 2;
} else if(("\r" === c )){
next = 2;
} else if(("*" === c )){
next = 5;
}
break;
case 5:
if(("/" === c )){
next = 6;
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

	return "keyword";

},function anonymous() {

	return "keyword";

},function anonymous() {

	return "keyword";

},function anonymous() {

	return "keyword";

},function anonymous() {

	return "keyword";

},function anonymous() {

	return "keyword";

},function anonymous() {

	return "keyword";

},function anonymous() {

	return "keyword";

},function anonymous() {

	return "keyword";

},function anonymous() {

	return "keyword";

},function anonymous() {

	return "keyword";

},function anonymous() {

	return "keyword";

},function anonymous() {

	return "keyword";

},function anonymous() {

	return "keyword";

},function anonymous() {

	return "keyword";

},function anonymous() {

	return "keyword";

},function anonymous() {

	return "keyword";

},function anonymous() {

	return "keyword";

},function anonymous() {

	return "keyword";

},function anonymous() {

	return "keyword";

},function anonymous() {

	return "keyword";

},function anonymous() {

	return "keyword";

},function anonymous() {

	return "keyword";

},function anonymous() {

	return "keyword";

},function anonymous() {

	return "keyword";

},function anonymous() {

	return "keyword";

},function anonymous() {

	return "keyword";

},function anonymous() {

	return "keyword";

},function anonymous() {

	return "keyword";

},function anonymous() {

	return "keyword";

},function anonymous() {

	return "op_increment";

},function anonymous() {

	return "op_decrement";

},function anonymous() {

	return "op_add";

},function anonymous() {

	return "op_sub";

},function anonymous() {

	return "op_mul";

},function anonymous() {

	return "op_div";

},function anonymous() {

	return "op_mod";

},function anonymous() {

	return "op_addAssign";

},function anonymous() {

	return "op_subAssign";

},function anonymous() {

	return "op_mulAssign";

},function anonymous() {

	return "op_divAssign";

},function anonymous() {

	return "op_modAssign";

},function anonymous() {

	return "op_andAssign";

},function anonymous() {

	return "op_orAssign";

},function anonymous() {

	return "op_xorAssign";

},function anonymous() {

	return "op_notequalCompare";

},function anonymous() {

	return "op_equalCompare";

},function anonymous() {

	return "op_LshiftEqual";

},function anonymous() {

	return "op_RshiftEqual";

},function anonymous() {

	return "op_greaterEqual";

},function anonymous() {

	return "op_lessEqual";

},function anonymous() {

	return "op_Lshift";

},function anonymous() {

	return "op_Rshift";

},function anonymous() {

	return "op_greater";

},function anonymous() {

	return "op_less";

},function anonymous() {

	return "op_assign";

},function anonymous() {

	return "op_andand";

},function anonymous() {

	return "op_oror";

},function anonymous() {

	return "op_and";

},function anonymous() {

	return "op_or";

},function anonymous() {

	return "op_not";

},function anonymous() {

	return "op_xor";

},function anonymous() {

	return "float_literal";

},function anonymous() {

	return "integer_literal";

},function anonymous() {

	return "boolean_literal";

},function anonymous() {

	return "null_literal";

},function anonymous() {

	return "string_literal";

},function anonymous() {

	return "character_literal";

},function anonymous() {

	return "identifier";

},function anonymous() {

	return "terminator";

},function anonymous() {

	return "field_invoker";

},function anonymous() {

	return "separator";

},function anonymous() {

	return "paranthesis_start";

},function anonymous() {

	return "paranthesis_end";

},function anonymous() {

	return "brackets_start";

},function anonymous() {

	return "brackets_end";

},function anonymous() {

	return "set_start";

},function anonymous() {

	return "set_end";

},function anonymous() {

	return "comment";

},function anonymous() {

	this.pushState('BLOCKCOMMENT');
	return "blockcomment_start";

},function anonymous() {

	this.popState();
	return "blockcomment_end";

},,function anonymous() {
 
},function anonymous() {

	return this.jjtext;

},function anonymous() {
 console.log("EOF"); return "EOF"; 
}];
this.states["DEFAULT"] = {};
this.states["DEFAULT"].dfa = new CDFA_DEFAULT();
this.states["BLOCKCOMMENT"] = {};
this.states["BLOCKCOMMENT"].dfa = new CDFA_BLOCKCOMMENT();
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