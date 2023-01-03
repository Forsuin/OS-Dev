void some_function() {

}

void main() {
    //pointer to first text cell in video memory
    char* video_memory = (char*) 0xb8000;

    *video_memory = 'X';

    some_function();
}