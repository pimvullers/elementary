# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="Sets DPMS settings found in org.pantheon.dpms"
HOMEPAGE="https://github.com/elementary/dpms-helper"
SRC_URI="https://github.com/elementary/dpms-helper/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
