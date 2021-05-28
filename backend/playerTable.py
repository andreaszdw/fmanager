#!/usr/bin/env python3

"""
    playerTable.py
"""
import wx
import wx.grid as gridlib

class Data(gridlib.GridTableBase):

    def __init__(self, colLabels, data):
        super().__init__()
        self.colLabels = colLabels

        self.data = data

    def GetNumberRows(self):
        return len(self.data)  # + 1

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


class Grid(gridlib.Grid):

    def __init__(self, parent, colLabels, data):
        super().__init__(parent, -1)

        table = Data(colLabels, data)

        self.SetTable(table, True)

        self.SetRowLabelSize(30)
        self.SetMargins(0, 0)
        self.AutoSizeColumns(False)

        # self.Bind(gridlib.EVT_GRID_CELL_LEFT_DCLICK, self.OnLeftDClick)

    def OnLeftDClick(self, event):
        print(event.GetRow())


class Main(wx.Frame):

    def __init__(self, parent):
        super().__init__(parent, -1, "Player Editor", size=(800, 600))
        panel = wx.Panel(self, -1, style=0)

        colLabels = [
            "Name", "Alter", "Vertrag", "Gehalt",
            "Fuss", "Position", "Fitness", "Schnelligkeit",
            "Ausdauer", "Passen", "Kopfball", "Schuss", "Zweikampf",
            "Taktik", "Potential", "Rating", "Experience"]

        data = [
            ["A", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            ["B", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            ["C", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        ]

        playerGrid = Grid(panel, colLabels, data)
        boxSizer = wx.BoxSizer(wx.VERTICAL)
        boxSizer.Add(playerGrid, 1, wx.EXPAND | wx.ALL, 5)
        panel.SetSizer(boxSizer)


if __name__ == '__main__':
    app = wx.App()
    frame = Main(None)
    frame.Show(True)
    app.MainLoop()
