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

        self._rows = self.GetNumberRows()
        self._cols = self.GetNumberCols()

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

    def ResetView(self, grid):
        """
        (Grid) -> Reset the grid view.   Call this to
        update the grid if rows and columns have been added or deleted
        """
        grid.BeginBatch()

        for current, new, delmsg, addmsg in [
            (self._rows, self.GetNumberRows(), gridlib.GRIDTABLE_NOTIFY_ROWS_DELETED, gridlib.GRIDTABLE_NOTIFY_ROWS_APPENDED),
            (self._cols, self.GetNumberCols(), gridlib.GRIDTABLE_NOTIFY_COLS_DELETED, gridlib.GRIDTABLE_NOTIFY_COLS_APPENDED),
        ]:

            if new < current:
                msg = Grid.GridTableMessage(self,delmsg,new,current-new)
                grid.ProcessTableMessage(msg)
            elif new > current:
                msg = Grid.GridTableMessage(self,addmsg,new-current)
                grid.ProcessTableMessage(msg)
                self.UpdateValues(grid)

        grid.EndBatch()

        self._rows = self.GetNumberRows()
        self._cols = self.GetNumberCols()

        # update the scrollbars and the displayed part of the grid
        grid.AdjustScrollbars()
        grid.ForceRefresh()


class Grid(gridlib.Grid):

    def __init__(self, parent, colLabels, data):
        super().__init__(parent, -1)

        self.data = Data(colLabels, data)

        self.SetTable(self.data, True)

        self.SetRowLabelSize(30)
        self.SetMargins(0, 0)
        self.AutoSizeColumns(False)

    def getValue(self, row, col):
        return self.data.GetValue(row, col)
    
    def sortColumn(self, col):

        def sortKey(elem):
            print(elem[col])
            return elem[col]

        name = self.data.colLabels[col]
        _data = []

        for row in self.data.data:
            #print(row[col])
            _data.append(row)

        _data.sort(key=sortKey)

        self.data.data = []

        for row in _data:
            self.data.data.append(row)

    def reset(self):
        self.data.ResetView(self)


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
