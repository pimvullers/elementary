# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit base

DESCRIPTION="A set of wallpapers used by the elementary OS"
HOMEPAGE="http://www.elementaryos.org/journal/luna-wallpapers-officially-revealed"
SRC_URI="https://launchpad.net/elementaryos/0.2-luna/luna-wallpapers/+download/luna-wallpapers.tar.gz"

LICENSE="CCPL-Attribution-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

pkg_setup() {
	S="${WORKDIR}"
}

src_install() {
	insinto /usr/share/backgrounds/elementary
	doins *.jpg
}

