#!/usr/bin/env python3

"""
    player_editor.py
"""
import wx
import wx.grid as gridlib

class PlayerTableData(gridlib.GridTableBase):

    def __init__(self):
        super().__init__()
        self.colLabels = [
            "Name", "Alter", "Vertrag", "Gehalt",
            "Fuss", "Position", "Fitness", "Schnelligkeit",
            "Ausdauer", "Passen", "Kopfball", "Schuss", "Zweikampf",
            "Taktik", "Potential", "Rating", "Experience"]

        self.dataTypes = [
            gridlib.GRID_VALUE_STRING,  # Name
            gridlib.GRID_VALUE_NUMBER,  # Alter
            gridlib.GRID_VALUE_NUMBER,  # Vertrag
            gridlib.GRID_VALUE_NUMBER,
            gridlib.GRID_VALUE_CHOICE,
            gridlib.GRID_VALUE_CHOICE,
            gridlib.GRID_VALUE_NUMBER,
            gridlib.GRID_VALUE_NUMBER,
            gridlib.GRID_VALUE_NUMBER,
            gridlib.GRID_VALUE_NUMBER,
            gridlib.GRID_VALUE_NUMBER,
            gridlib.GRID_VALUE_NUMBER,
            gridlib.GRID_VALUE_NUMBER,
            gridlib.GRID_VALUE_NUMBER,
            gridlib.GRID_VALUE_NUMBER,
            gridlib.GRID_VALUE_NUMBER,
            gridlib.GRID_VALUE_NUMBER
        ]

        self.data = [
            ["A", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            ["B", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            ["C", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        ]

    def GetNumberRows(self):
        return len(self.data) + 1

    def GetNumberCols(self):
        return(len(self.data[0]))

    def IsEmptyCell(self, row, col):
        try:
            return not self.data[row][col]
        except IndexError:
            return True

    def GetValue(self, row, col):
        try:
            return self.data[row][col]
        except IndexError:
            return ''

    def SetValue(self, row, col, value):
        def innerSetValue(row, col, value):
            try:
                self.data[row][col] = value
            except IndexError:
                # add a new row
                self.data.append([''] * self.GetNumberCols())
                innerSetValue(row, col, value)

                # tell the grid we've added a row
                msg = gridlib.GridTableMessage(
                    self,
                    gridlib.GRIDTABLE_NOTIFY_ROWS_APPENDED,
                    1
                )

                self.GetView().ProcessTableMessage(msg)
        innerSetValue(row, col, value)

    def GetColLabelValue(self, col):
        return self.colLabels[col]

    def GetTypeName(self, row, col):
        return self.dataTypes[col]

    def CanGetValueAs(self, row, col, typeName):
        colType = self.dataTypes[col].split(':')[0]
        if typeName == colType:
            return True
        else:
            return False

    def CanSetValueAs(self, row, col, typeName):
        return self.CanGetValueAs(row, col, typeName)


class PlayerTableGrid(gridlib.Grid):

    def __init__(self, parent):
        super().__init__(parent, -1)

        table = PlayerTableData()

        self.SetTable(table, True)

        self.SetRowLabelSize(80)
        self.SetMargins(0, 0)
        self.AutoSizeColumns(True)


class Main(wx.Frame):

    def __init__(self, parent):
        super().__init__(parent, -1, "Player Editor", size=(800, 600))
        panel = wx.Panel(self, -1, style=0)
        playerGrid = PlayerTableGrid(panel)
        boxSizer = wx.BoxSizer(wx.VERTICAL)
        boxSizer.Add(playerGrid, 1, wx.EXPAND | wx.ALL, 5)
        panel.SetSizer(boxSizer)


if __name__ == '__main__':
    app = wx.App()
    frame = Main(None)
    frame.Show(True)
    app.MainLoop()
