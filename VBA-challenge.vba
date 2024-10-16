Sub stock_data()
    Dim ticker As Long
    Dim total_stock_volume As Double
    Dim LastRow As Long
    Dim ws As Worksheet
    Dim r As Long
    Dim opening_price As Double
    Dim closing_price As Double
    Dim price_change As Double
    Dim percent_change As Double
    Dim greatest_percent_increase As Double
    Dim greatest_percent_decrease As Double
    Dim greatest_total_volume As Double
    Dim greatest_percent_increase_ticker As String
    Dim greatest_percent_decrease_ticker As String
    Dim greatest_total_volume_ticker As String
    
    ' Loop through each worksheet
    For Each ws In Worksheets
        ' Initialize variables for each worksheet
        ticker = 2 ' Start from row 2 for ticker
        total_stock_volume = 0
        
        ' Initialize variables for greatest values
        greatest_percent_increase = -200 ' Start with a very low number
        greatest_percent_decrease = 200 ' Start with a very high number
        greatest_total_volume = 0
        
        ' Find the last row for the current worksheet
        LastRow = ws.Cells(Rows.Count, 1).End(xlUp).Row
        
        ' Loop through rows starting from row 2 to LastRow
        For r = 2 To LastRow
            
            ' Get the opening price only for the first row of each ticker
            If r = 2 Or ws.Cells(r, 1).Value <> ws.Cells(r - 1, 1).Value Then
                opening_price = ws.Cells(r, "C").Value
                total_stock_volume = 0 ' Reset the total stock volume for new ticker
            End If
            
            ' Get the closing price
            closing_price = ws.Cells(r, "F").Value
            
            ' Check if the current cell value is different from the next cell value
            If r = LastRow Or ws.Cells(r, 1).Value <> ws.Cells(r + 1, 1).Value Then
                ' Store the ticker symbol in column I
                ws.Cells(ticker, "I").Value = ws.Cells(r, 1).Value
                
                ' Store the total stock volume in column L
                ws.Cells(ticker, "L").Value = total_stock_volume + ws.Cells(r, "G").Value
                
                ' Calculate the price change
                price_change = closing_price - opening_price
                
                ' Calculate the percent change
                If opening_price <> 0 Then
                    percent_change = (price_change / opening_price) * 100 / 100
                Else
                    percent_change = 0
                End If
                
                ' Store the price change in column J
                ws.Cells(ticker, "J").Value = price_change
                
                ' Color code negative price changes to red
                If price_change < 0 Then
                    ws.Cells(ticker, "J").Interior.Color = RGB(255, 0, 0) ' Red color for negative changes
                Else
                    ws.Cells(ticker, "J").Interior.Color = RGB(0, 255, 0) ' Green color for positive changes
                End If
                
                If price_change = 0 Then
                    ws.Cells(ticker, "J").Interior.Color = RGB(255, 255, 255) ' white color for zero
                End If
                
                ' Store the percent change in column K
                ws.Cells(ticker, "K").Value = percent_change
                
                ' Check for greatest percent increase
                If percent_change > greatest_percent_increase Then
                    greatest_percent_increase = percent_change
                    greatest_percent_increase_ticker = ws.Cells(r, 1).Value
                End If
                
                ' Check for greatest percent decrease
                If percent_change < greatest_percent_decrease Then
                    greatest_percent_decrease = percent_change
                    greatest_percent_decrease_ticker = ws.Cells(r, 1).Value
                End If
                
                ' Check for greatest total volume
                If total_stock_volume + ws.Cells(r, "G").Value > greatest_total_volume Then
                    greatest_total_volume = total_stock_volume + ws.Cells(r, "G").Value
                    greatest_total_volume_ticker = ws.Cells(r, 1).Value
                End If
                
                ticker = ticker + 1 ' Move to the next row for the next ticker
            End If
            
            ' Accumulate the total stock volume
            total_stock_volume = total_stock_volume + ws.Cells(r, "G").Value
            
        Next r
        
        ' Write the greatest values to the worksheet
        ws.Cells(2, "Q").Value = greatest_percent_increase
        ws.Cells(3, "Q").Value = greatest_percent_decrease
        ws.Cells(4, "Q").Value = greatest_total_volume
        
        ws.Cells(2, "P").Value = greatest_percent_increase_ticker
        ws.Cells(3, "P").Value = greatest_percent_decrease_ticker
        ws.Cells(4, "P").Value = greatest_total_volume_ticker
        
    Next ws
            
End Sub

