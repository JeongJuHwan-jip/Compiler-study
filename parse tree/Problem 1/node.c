
#include <stdio.h>
#include <string.h>
#include <stdlib.h>


typedef struct NODE{
	//todo: define struct NODE
char* name;
struct NODE* parent;
struct NODE* child;
struct NODE* prev;
struct NODE* next;
    }NODE;




//MakeNode: make a new node
NODE* MakeNode(char* name){
	//todo
	NODE* node = (NODE*)malloc(sizeof(NODE));
	node->name = name;
	node->parent = NULL;
	node->child = NULL;
	node->prev = NULL;
	node->next = NULL;
	}


// Insert node (parent-child): append a child node to parent node
void InsertChild(NODE* parent_node, NODE* this_node){
	//todo
	parent_node->child = this_node;
	this_node->parent = parent_node;
	}


// Insert node (prev-next): append a next node to prev node
void InsertSibling(NODE* prev_node, NODE* this_node){
	//todo
	prev_node->next = this_node;
	this_node->prev = prev_node;
	}


//Tree walk algorithm
void WalkTree(NODE* node){
	//todo
	if(node == NULL) return;
	printf("\n(%s", node->name);
	WalkTree(node->child);
	printf(")");
	WalkTree(node->next);
	}

int main()
{
NODE* A = MakeNode(strdup("A"));
NODE* B = MakeNode(strdup("B"));
NODE* C = MakeNode(strdup("C"));
NODE* D = MakeNode(strdup("D"));
NODE* E = MakeNode(strdup("E"));
NODE* F = MakeNode(strdup("F"));
NODE* G = MakeNode(strdup("G"));
NODE* H = MakeNode(strdup("H"));
NODE* I = MakeNode(strdup("I"));

NODE* Tree = A;
InsertChild(A, B);
InsertChild(B, C);
InsertSibling(C, D);
InsertSibling(B, E);
InsertSibling(E, I);
InsertChild(E, F);
InsertSibling(F, G);
InsertSibling(G, H);

WalkTree(Tree);

return 0;
}
