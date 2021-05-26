#!/usr/bin/env python3

"""
    player_editor.py
"""
import wx
import wx.grid as gridlib

class PlayerTable(gridlib.GridTableBase):

    def __init__(self):
        super().__init__()
        self.colLabels = ["Name", "Alter", "Vertrag", "Gehalt"]

        self.dataTyps = [
            gridlib.GRID_VALUE_STRING,
            gridlib.GRID_VALUE_NUMBER,
            gridlib.GRID_VALUE_NUMBER,
            gridlib.GRID_VALUE_NUMBER
        ]

        self.data = [
            ["Karl-Heinz Förster", 21, 3, 130009],
            ["Werner Schneider", 25, 5, 800000]
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


class Main(wx.Frame):

    def __init__(self, parent):
        super().__init__(parent, -1, "Player Editor", size=(800, 600))
        panel = wx.Panel(self, -1, style=0)
        testText = wx.StaticText(panel, label="Test TEST")

        boxSizer = wx.BoxSizer(wx.VERTICAL)
        boxSizer.Add(testText)
        panel.SetSizer(boxSizer)


if __name__ == '__main__':
    app = wx.App()
    frame = Main(None)
    frame.Show(True)
    app.MainLoop()
