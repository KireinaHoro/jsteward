# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5} )
inherit distutils-r1 eutils

DESCRIPTION="BGmi is a cli tool for subscribed bangumi."
HOMEPAGE="https://github.com/RicterZ/BGmi"

MY_P="BGmi"
SRC_URI="https://github.com/RicterZ/${MY_P}/archive/${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="
	>=dev-python/beautifulsoup-4.4.0:4[${PYTHON_USEDEP}]
	>=dev-python/icalendar-3.11.3[${PYTHON_USEDEP}]
	>=dev-python/lxml-3.2.1[${PYTHON_USEDEP}]
	>=dev-python/requests-2.9.1[${PYTHON_USEDEP}]
	>=www-servers/tornado-4.0.2[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}-${PV}"

src_prepare() {
	default
	epatch "${FILESDIR}/${P}-exclude-tests.patch"
}
