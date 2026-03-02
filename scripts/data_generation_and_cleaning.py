import matplotlib.pyplot as plt
import pandas as pd
import random

companies = [
    "Walmart","Amazon","Apple","Samsung Electronics","Toyota Motor",
    "Volkswagen","BP","Shell","Microsoft","Alphabet",
    "Exxon Mobil","Chevron","Reliance Industries","Tata Motors","Infosys",
    "Accenture","IBM","Intel","Cisco","Oracle",
    "Meta","Netflix","Adobe","Salesforce","Sony",
    "LG Electronics","BMW","Mercedes-Benz","Ford","General Motors",
    "Siemens","Bosch","Hitachi","Panasonic","Philips",
    "Pfizer","Johnson & Johnson","Roche","Novartis","Merck",
    "HSBC","JPMorgan Chase","Goldman Sachs","Morgan Stanley","Citi",
    "Visa","Mastercard","PayPal","American Express","BlackRock",
    "Deloitte","EY","PwC","KPMG","Capgemini"
]

industries = [
    "Retail","Technology","Automobile","Energy",
    "Finance","Healthcare","Consulting","Manufacturing"
]

rows = []

for company in companies:
    rows.append({
        "company_name": company,
        "industry": random.choice(industries),
        "founded_year": random.randint(1890, 2005),
        "revenue_usd_bn": round(random.uniform(25, 600), 2)
    })

df = pd.DataFrame(rows)
df.to_csv("mnc_base_data.csv", index=False)

print("Base MNC dataset created")
print("Rows:", df.shape[0])

df = pd.read_csv("mnc_base_data.csv")

tech_stack = [
    "AI","Cloud","Big Data","Automation",
    "IoT","Cybersecurity","ERP","Blockchain",
    "Machine Learning","DevOps"
]

df["digital_maturity_score"] = [random.randint(45, 95) for _ in range(len(df))]

df["key_technologies"] = [
    ", ".join(random.sample(tech_stack, 4))
    for _ in range(len(df))
]

df["digital_category"] = df["digital_maturity_score"].apply(
    lambda x: "High" if x >= 75 else "Medium" if x >= 60 else "Low"
)

df.to_csv("mnc_digital_transformation.csv", index=False)

print("Digital transformation dataset ready")
print("Rows:", df.shape[0])

# Show all columns
pd.set_option('display.max_columns', None)

# Show all rows if needed
pd.set_option('display.max_rows', None)

# Now display your dataframe
print(df)

# Load data
df = pd.read_csv("mnc_digital_transformation.csv")

# ----------------------------------
# 1️⃣ Digital Maturity by Industry
# ----------------------------------
industry_avg = df.groupby("industry")["digital_maturity_score"].mean()

plt.figure()
industry_avg.plot(kind="bar")
plt.title("Average Digital Maturity by Industry")
plt.xlabel("Industry")
plt.ylabel("Digital Maturity Score")
plt.xticks(rotation=45)
plt.tight_layout()
plt.show()

# ----------------------------------
# 2️⃣ Digital Category Distribution
# ----------------------------------
category_counts = df["digital_category"].value_counts()

plt.figure()
category_counts.plot(kind="pie", autopct="%1.1f%%")
plt.title("Digital Maturity Category Distribution")
plt.ylabel("")
plt.show()

# ----------------------------------
# 3️⃣ Revenue vs Digital Maturity
# ----------------------------------
plt.figure()
plt.scatter(
    df["revenue_usd_bn"],
    df["digital_maturity_score"]
)
plt.xlabel("Revenue (USD Billion)")
plt.ylabel("Digital Maturity Score")
plt.title("Revenue vs Digital Maturity")
plt.tight_layout()
plt.show()

df.to_csv("mnc_digital_transformation.csv", index=False)
print("CSV exported successfully")

