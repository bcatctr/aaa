SRC 	= ./src
OBJ 	= ./obj
BIN 	= ./bin
FILES 	= dataLoader.cpp lda.cpp main.cpp Log.cpp
INCLUDE = -I./include 
SOURCES = $(patsubst %,$(SRC)/%,$(FILES))
OBJECTS = $(patsubst %.cpp,$(OBJ)/%.o,$(FILES))

TARGET 	= $(BIN)/paraLDA

CXX  	= mpic++
COPT 	= -O3
CFLAGS  = -Wl,-rpath,/opt/gcc/4.9.2/lib64 $(INCLUDE) -std=c++11 -g -Wall -Wextra -Werror -Wno-literal-suffix -Wno-unused-function -Wno-unused-parameter $(COPT)
LDFLAGS = -Wl,-rpath,/opt/gcc/4.9.2/lib64 -lmpi

MKDIR_P = @mkdir -p

all: $(TARGET)

run: $(TARGET)
	$(MKDIR_P) output
	@$(TARGET) parameters.txt

$(OBJ)/%.o: $(SRC)/%.cpp
	$(MKDIR_P) $(OBJ)
	$(CXX) $(CFLAGS) -c $< -o $@

$(TARGET): $(OBJECTS)
	$(MKDIR_P) $(BIN)
	$(CXX) $(LDFLAGS) $(OBJECTS) -o $(TARGET)

clean:
	rm -rf $(BIN)
	rm -rf $(OBJ)
