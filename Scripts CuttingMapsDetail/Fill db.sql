USE CuttingMapsDetail
GO
INSERT INTO [dbo].[Material]([Title],[FullName],[Thick])
VALUES('���������','��������� �����������', '10'),
('����','���� �������', '100'),
('������','������ �����������', '25'),
('�����','����� �������', '200'),
('�����','����� ������', '1')
GO
INSERT INTO [dbo].[Sheet]([Title],[FullName],[Width],[Height])
VALUES('���� ���������','���� ������������ ���������','1000','1000'),
('���� ����','���� ������� ����','100','100'),
('���� ������','���� ������������ ������','2000','1500'),
('���� �����','���� ������� �����','5000','4000'),
('���� �����','���� ������ �����','1000','1000')
GO
INSERT INTO [dbo].[Detail]([Title],[FullName],[Countours])
VALUES('�������','������� ����������������', 0x0101010101),
('����','���� ���������', 0x0101010100),
('�����','����� �������', 0x0101010101),
('�������','������� ���������', 0x0101010101),
('�����','����� ������������', 0x0100010100)
GO
INSERT INTO [dbo].[CuttingMap]([Title],[FullName],[MaterialId],[SheetId])
VALUES('����� ������� �������','����� ������� ������� ����������������','1','1'),
('����� ������� �����','����� ������� ����� ����������','4','4'),
('����� ������� ������','����� ������� ������ ��������','4','4'),
('����� ������� �����','����� ������� ����� ����������','3','3'),
('����� ������� �������','����� ������� ���������� �������','5','5'),
('����� ������� �����','����� ������� ������������ �����','2','2')
GO
INSERT INTO [dbo].[CuttingMapDetail]([CuttingMapId],[DetailId])
VALUES('1','1'),
('2','2'),
('3','3'),
('4','2'),
('5','4'),
('6','5')
GO