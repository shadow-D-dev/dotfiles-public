Vim�UnDo� ����p�f��=��n+V���Vh�mhbی�   @   4app.get('/tasks', (req: Request, res: Response) => {                              gG�.    _�                            ����                                                                                                                                                                                                                                                                                                                                                             gG�,     �                   �               5��                   6                      i      5�_�                             ����                                                                                                                                                                                                                                                                                                                                                             gG�-    �          A          5import express, { Request, Response } from 'express';�         7      x  { id: 1, title: 'Finish project', description: 'Complete the project by the end of the week', status: 'In Progress' },   e  { id: 2, title: 'Buy groceries', description: 'Purchase vegetables and fruits', status: 'Pending' }�         7      4app.get('/tasks', (req: Request, res: Response) => {�         7      5app.post('/tasks', (req: Request, res: Response) => {�       "   7      8app.put('/tasks/:id', (req: Request, res: Response) => {�   "   $   7      5  const task = tasks.find(t => t.id == parseInt(id));�   )   +   7      +    res.status(404).send('Task not found');�   .   0   7      ;app.delete('/tasks/:id', (req: Request, res: Response) => {�   0   2   7      2  tasks = tasks.filter(t => t.id != parseInt(id));�   5   7   7      9  console.log('Server running on http://localhost:3000');5��    5          )       )   :      )       )       �    0                    �                    �    .                    s                    �    )                    ;                    �    "                    h                    �                                              �       	                 :                    �                        �                    �             e         �       �             �               4       4           5       4       5�_�                             ����                                                                                                                                                                                                                                                                                                                                                             gG��     �              �                     5npm install express @types/express typescript ts-node5��                                         6       5��