import controlP5.*;


ControlP5 cp5;
float background = 0;

void setup() {
  size(400, 200);
  cp5 = new ControlP5(this);

  EditableNumberbox nbox = new EditableNumberbox(cp5, "background"); 
  nbox
    .setSize(100, 20)
    .setPosition(100, 85)
    .setRange(0, 255)
    ;
}

void draw() {
  background(background);
}