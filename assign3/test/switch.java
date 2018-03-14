public class DemoTranslation {
	public void main(String[] args) {
		boolean wflg = false, tflg = false;
		boolean dflg = false;
		byte c = 0;
		switch(c) {
		case 'w':
		case 'W':
			wflg = true;
			break;
		case 't':
		case 'T':
			tflg = true;
			break;
		case 'd':
			dflg = true;
			break;
		}
	}
}